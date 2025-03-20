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
    required this. carDetails, 
  });

  @override
  State<CheckoutPaymentScreen> createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<CheckoutPaymentScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      borderColor: AppColors.textFormFieldBorderColor,
                    )
                  ),
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

    // Create booking
    final success = await provider.createBooking(
      context,
      email: _emailController.text,
      phoneNumber: _phoneController.text,
      amount: widget.totalAmount.toDouble(),
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
    super.dispose();
  }
}
