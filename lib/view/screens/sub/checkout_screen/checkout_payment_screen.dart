import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_text_styles.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/booking_price.dart';
import 'package:hny_main/view/screens/sub/checkout_screen/widgets/radius_tile.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';
import 'package:hny_main/view/widgets/app_textform_widget.dart';
import 'package:hny_main/view/widgets/back_button.dart';
import 'package:provider/provider.dart';

class CheckoutPaymentScreen extends StatefulWidget {
  final int totalAmount;
  final ArrCar carDetails;
  
  const CheckoutPaymentScreen({
    super.key,
    required this.totalAmount,
    required this.carDetails, 
  });

  @override
  State<CheckoutPaymentScreen> createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<CheckoutPaymentScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _customAmountController = TextEditingController();

  String _selectedPaymentAmountOption = 'Full Amount';
  
  // Calculate minimum amount (30% of total)
  double get _minimumAmount => widget.totalAmount * 0.3;

  @override
  Widget build(BuildContext context) {
    log("minimum amount: ${widget.totalAmount}");
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        return Scaffold(
          backgroundColor: AppColors.paymentScreenBackgroundColor,
          appBar: AppBar(
            title: const Text(
              "Payment",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: AppColors.paymentScreenBackgroundColor,
            leading: const CommonBackButton(
              showBorder: true,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Payment Method Selection
                  const AppText(
                    "Select Payment Option",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  const Gap(20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.paymentScreenBackgroundColor,
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(1, 1),
                          spreadRadius: 1,
                          color: Color.fromARGB(255, 231, 231, 231),
                          blurRadius: 6
                        )
                      ]
                    ),
                    width: double.infinity,
                    child: Column(
                      children: [
                        RadioBoxElement(
                          status: bookingProvider.selectedPaymentMethod == "TAP_LINK",
                          title: "Payment with link",
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          onChanged: (_) => bookingProvider.updatePaymentMethod("TAP_LINK"),
                        ),
                        const SizedBox(width: double.infinity, child: Divider()),
                        RadioBoxElement(
                          status: bookingProvider.selectedPaymentMethod == "CASH",
                          title: "Payment on pickup",
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          onChanged: (_) => bookingProvider.updatePaymentMethod("CASH"),
                        ),
                      ],
                    ),
                  ),

                     const Gap(15),
                  const AppText(
                    "Enter Email Id",
                    style: AppTextStyles.subText,
                  ),
                  const Gap(6),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.paymentScreenBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 1),
                          spreadRadius: 0.1,
                          color: Color.fromARGB(255, 240, 240, 240),
                          blurRadius: 15
                        )
                      ]
                    ),
                    child: CustomTextFormField(
                      controller: _emailController,
                      label: "",
                      hint: "Enter your email",
                      borderColor: AppColors.textFormFieldBorderColor,
                    )
                  ),

                  // Phone Number Input
                  const Gap(15),
                  const AppText(
                    "Enter Mobile Number",
                    style: AppTextStyles.subText,
                  ),
                  const Gap(6),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.paymentScreenBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 1),
                          spreadRadius: 0.1,
                          color: Color.fromARGB(255, 240, 240, 240),
                          blurRadius: 15
                        )
                      ]
                    ),
                    child: CustomTextFormField(
                      controller: _phoneController,
                      label: "",
                      hint: "Enter your mobile number",
                      keyboardType: TextInputType.phone,
                      borderColor: AppColors.textFormFieldBorderColor,
                    )
                  ),
                  
                  // Payment Amount Options
                  const Gap(15),
                  const AppText(
                    "Select Payment Amount",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  const Gap(10),
                  _buildPaymentAmountOptions(),
                  
                  // Custom amount field (conditionally rendered)
                  if (_selectedPaymentAmountOption == 'Custom Amount')
                    _buildCustomAmountField(),

                  // Email Input
               
                ],
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 100,
            child: BookingPrice(
              title: "Total Amount",
              value: "${widget.totalAmount}",
              buttonName: "Pay now",
              isLoading: bookingProvider.isLoading,
              onTap: () => _handlePayNow(context, bookingProvider),
            )
          ),
        );
      },
    );
  }

  Widget _buildPaymentAmountOptions() {
    final paymentOptions = ['Full Amount', 'Minimum Amount', 'Custom Amount'];
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.paymentScreenBackgroundColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
            spreadRadius: 1,
            color: Color.fromARGB(255, 231, 231, 231),
            blurRadius: 6
          )
        ]
      ),
      child: Column(
        children: paymentOptions.map((option) {
          return Column(
            children: [
              RadioBoxElement(
                title: option,
                status: _selectedPaymentAmountOption == option,
                padding: const EdgeInsets.only(right: 16, left: 16),
                onChanged: (_) {
                  setState(() {
                    _selectedPaymentAmountOption = option;
                  });
                },
              ),
              if (option != paymentOptions.last) 
                const SizedBox(width: double.infinity, child: Divider()),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCustomAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(15),
        AppText(
          "Enter Custom Amount (Minimum: ${_minimumAmount.toStringAsFixed(2)} AED)",
          style: AppTextStyles.subText,
        ),
        const Gap(6),
        Container(
          decoration: const BoxDecoration(
            color: AppColors.paymentScreenBackgroundColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                spreadRadius: 0.1,
                color: Color.fromARGB(255, 240, 240, 240),
                blurRadius: 15
              )
            ]
          ),
          child: CustomTextFormField(
            controller: _customAmountController,
            label: "",
            hint: "Enter custom amount",
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an amount';
              }
              final amount = double.tryParse(value);
              if (amount == null || amount < _minimumAmount) {
                return 'Amount must be at least ${_minimumAmount.toStringAsFixed(2)} AED';
              }
              return null;
            },
          )
        ),
      ],
    );
  }

  Future<void> _handlePayNow(BuildContext context, BookingProvider provider) async {
    // Validate inputs
    if (provider.selectedPaymentMethod == "TAP_LINK") {
      if (_emailController.text.isEmpty || _phoneController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all required fields'))
        );
        return;
      }
    }

    // Determine the payment amount
    double paymentAmount;
    switch (_selectedPaymentAmountOption) {
      case 'Full Amount':
        paymentAmount = widget.totalAmount.toDouble();
        break;
      case 'Minimum Amount':
        paymentAmount = _minimumAmount;
        break;
      case 'Custom Amount':
        final customAmount = double.tryParse(_customAmountController.text);
        if (customAmount == null || customAmount < _minimumAmount) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Minimum is ${_minimumAmount.toStringAsFixed(2)} AED'))
          );
          return;
        }
        paymentAmount = customAmount;
        break;
      default:
        paymentAmount = widget.totalAmount.toDouble();
    }

    // Create booking
    final success = await provider.createBooking(
      context,
      email: _emailController.text,
      phoneNumber: _phoneController.text,
      amount: paymentAmount,
      carDetails: widget.carDetails
    );

    if (success) {
      // Navigate back to home or success screen
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _customAmountController.dispose();
    super.dispose();
  }
}