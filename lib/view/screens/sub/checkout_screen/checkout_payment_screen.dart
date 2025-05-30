import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_text_styles.dart';
import 'package:hny_main/data/models/cart/cartlist_model.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/data/providers/mycart_provider.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/booking_price.dart';
import 'package:hny_main/view/screens/sub/checkout_screen/widgets/radius_tile.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';
import 'package:hny_main/view/widgets/app_textform_widget.dart';
import 'package:hny_main/view/widgets/back_button.dart';
import 'package:provider/provider.dart';

class CheckoutPaymentScreen extends StatefulWidget {
  final bool? isCartPage;
  final int totalAmount;
  final ArrCar? carDetails;
  final ArrList? cartdata;

  const CheckoutPaymentScreen({
    super.key,
    required this.totalAmount,
    this.carDetails,
    this.isCartPage = false,
    this.cartdata,
  });

  @override
  State<CheckoutPaymentScreen> createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<CheckoutPaymentScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _customAmountController = TextEditingController();
  String _countryCode = '971'; // Default country code for UAE

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
                              blurRadius: 6)
                        ]),
                    width: double.infinity,
                    child: Column(
                      children: [
                        RadioBoxElement(
                          status: bookingProvider.selectedPaymentMethod ==
                              "TAP_LINK",
                          title: "Payment with link",
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          onChanged: (_) =>
                              bookingProvider.updatePaymentMethod("TAP_LINK"),
                        ),
                        const SizedBox(
                            width: double.infinity, child: Divider()),
                        RadioBoxElement(
                          status:
                              bookingProvider.selectedPaymentMethod == "CASH",
                          title: "Payment on pickup",
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          onChanged: (_) =>
                              bookingProvider.updatePaymentMethod("CASH"),
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
                                blurRadius: 15)
                          ]),
                      child: CustomTextFormField(
                        controller: _emailController,
                        label: "",
                        hint: "Enter your email",
                        borderColor: AppColors.textFormFieldBorderColor,
                      )),

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
                              blurRadius: 15)
                        ]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Country Code Selector
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: CountryCodePicker(
                            onChanged: (CountryCode countryCode) {
                              setState(() {
                                _countryCode = countryCode.dialCode ?? '971';
                              });
                            },
                            initialSelection: 'AE',
                            favorite: const ['AE'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                            padding: EdgeInsets.zero,
                            dialogSize: Size(
                                MediaQuery.of(context).size.width * 0.9,
                                MediaQuery.of(context).size.height * 0.6),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Phone number input
                        Expanded(
                          child: CustomTextFormField(
                            controller: _phoneController,
                            label: "",
                            hint: "Enter your mobile number",
                            keyboardType: TextInputType.phone,
                            borderColor: AppColors.textFormFieldBorderColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Payment Amount Options
                  const Gap(15),
                  const AppText(
                    "Select Payment Amount",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  const Gap(10),
                  _buildPaymentAmountOptions(widget.totalAmount),

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
              )),
        );
      },
    );
  }

  Widget _buildPaymentAmountOptions(totalAmount) {
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
                blurRadius: 6)
          ]),
      child: Column(
        children: paymentOptions.map((option) {
          return Column(
            children: [
              RadioBoxElement(
                title:
                    "${option}      ${_selectedPaymentAmountOption == "Minimum Amount" && option == "Minimum Amount" ? (totalAmount * (30 / 100)).toStringAsFixed(1) + " AED" : ""}",
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
                      blurRadius: 15)
                ]),
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
            )),
      ],
    );
  }

  Future<void> _showSuccessDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Booking Successful!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Your booking has been confirmed. You will redirect to dashboard.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      while (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showFailureDialog(BuildContext context, String message) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Booking Failed',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Try Again',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _handlePayNow(
      BuildContext context, BookingProvider provider) async {
    log("pay now >>>>>....");

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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text('Minimum is ${_minimumAmount.toStringAsFixed(2)} AED')));
          return;
        }
        paymentAmount = customAmount;
        break;
      default:
        paymentAmount = widget.totalAmount.toDouble();
    }

    // Create booking
    log("pay now 2 >>>>>....");

    final phoneNumber = _countryCode + _phoneController.text;
    final success = await provider.createBooking(context,
        email: _emailController.text,
        phoneNumber: phoneNumber,
        totalFinalAmount: widget.totalAmount.toDouble(),
        payedAmount: paymentAmount,
        totalVehicleAmount: provider
            .calculateTotalAmount(
                widget.isCartPage == true
                    ? widget.cartdata?.itemDetails?.intPricePerDay?.toInt() ?? 0
                    : widget.carDetails?.intPricePerDay?.toInt() ?? 0,
                widget.isCartPage == true
                    ? widget.cartdata?.itemDetails?.intPricePerWeek?.toInt() ??
                        0
                    : widget.carDetails?.intPricePerWeek?.toInt() ?? 0,
                widget.isCartPage == true
                    ? widget.cartdata?.itemDetails?.intPricePerMonth?.toInt() ??
                        0
                    : widget.carDetails?.intPricePerMonth?.toInt() ?? 0)
            .toDouble(),
        totalGadgetsAmount: provider.totalGadgetPrice,
        carDetails: ArrCar(
          strImgUrl: widget.carDetails?.strImgUrl,
          id: widget.isCartPage == true
              ? widget.cartdata?.itemDetails?.id ?? ''
              : widget.carDetails?.id ?? '',
          strCarNumber: widget.isCartPage == true
              ? widget.cartdata?.itemDetails?.strCarNumber ?? ''
              : widget.carDetails?.strCarNumber ?? '',
          strBrand: widget.isCartPage == true
              ? widget.cartdata?.itemDetails?.strBrand ?? ''
              : widget.carDetails?.strBrand ?? '',
          strModel: widget.isCartPage == true
              ? widget.cartdata?.itemDetails?.strModel ?? ''
              : widget.carDetails?.strModel ?? '',
          strDescription: widget.isCartPage == true
              ? widget.cartdata?.itemDetails?.strDescription ?? ''
              : widget.carDetails?.strDescription ?? '',
          intPricePerDay: widget.isCartPage == true
              ? widget.cartdata?.itemDetails?.intPricePerDay?.toInt() ?? 0
              : widget.carDetails?.intPricePerDay?.toInt() ?? 0,
          intPricePerWeek: widget.isCartPage == true
              ? widget.cartdata?.itemDetails?.intPricePerWeek?.toInt() ?? 0
              : widget.carDetails?.intPricePerWeek?.toInt() ?? 0,
          intPricePerMonth: widget.isCartPage == true
              ? widget.cartdata?.itemDetails?.intPricePerMonth?.toInt() ?? 0
              : widget.carDetails?.intPricePerMonth?.toInt() ?? 0,
        ));

    if (success) {
      final homeController =
          Provider.of<HomeController>(context, listen: false);
      homeController.getCarDataList(
          endDate: homeController.selecteEnddDate,
          startDate: homeController.selecteStratdDate,
          context: context);
          Provider.of<MyCartProvider>(context,listen: false).fetchCartItems();
      await _showSuccessDialog(context);
    } else {
      await _showFailureDialog(
          context, 'Failed to create booking. Please try again.');
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
