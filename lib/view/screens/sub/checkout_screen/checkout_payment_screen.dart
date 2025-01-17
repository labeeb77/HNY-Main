import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_text_styles.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/add_gadget_bottomsheet.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/widgets/booking_price.dart';
import 'package:hny_main/view/screens/sub/checkout_screen/widgets/radiou_tile.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';
import 'package:hny_main/view/widgets/app_textform_widget.dart';
import 'package:hny_main/view/widgets/back_button.dart';

class CheckoutPaymentScreen extends StatelessWidget {
  CheckoutPaymentScreen({super.key});

  final TextEditingController _textEditingController = TextEditingController();
    final TextEditingController _textEditingControlle1r = TextEditingController();


  @override
  Widget build(BuildContext context) {
    _textEditingControlle1r.text = 
    "12,510 AED";
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
                          blurRadius: 6)
                    ]),
                width: double.infinity,
                child: const Column(
                  children: [
                    RadioBoxElement(
                      status: true,
                      title: "Payment with cards",
                      padding: const EdgeInsets.only(top: 6, right: 16, left: 16),
                    ),
                    SizedBox(width: double.infinity, child: Divider()),
                    RadioBoxElement(
                      status: false,
                      title: "Payment with link",
                      padding:
                          const EdgeInsets.only(right: 16, bottom: 6, left: 16),
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
                    controller: _textEditingController,
                    label: "",
                    hint: "",
                    borderColor: AppColors.textFormFieldBorderColor,
                  )),
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
                  child: CustomTextFormField(
                    controller: _textEditingController,
                    label: "",
                    hint: "",
                    borderColor: AppColors.textFormFieldBorderColor,
                  )),
              const Gap(15),
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
                child: const Column(
                  children: [
                    RadioBoxElement(
                      status: true,
                      title: "Payment with cards",
                      padding: const EdgeInsets.only(top: 6, right: 16, left: 16),
                    ),
                    SizedBox(width: double.infinity, child: Divider()),
                    RadioBoxElement(
                      status: false,
                      title: "Payment with link",
                      padding: const EdgeInsets.only(right: 16, left: 16),
                    ),
                    SizedBox(width: double.infinity, child: Divider()),
                    RadioBoxElement(
                      status: false,
                      title: "Payment with link",
                      padding:
                          const EdgeInsets.only(right: 16, bottom: 6, left: 16),
                    ),
                  ],
          
                
                ),
              ),
              const Gap(15),
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
                    controller: _textEditingControlle1r,
                    label: "",
                    hint: "",
                    borderColor: AppColors.textFormFieldBorderColor,
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
          height: 100,
          child: BookingPrice(
            title: "Total Amount",
            value: "12,510",
            onTap: () {
             
            },
            buttonName: "Pay now",
          )),
    );
  }
}

