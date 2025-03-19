import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/screens/main/Bookings/widgets/payment_options_widget.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:provider/provider.dart';

class CompletePaymentSheet extends StatelessWidget {
  const CompletePaymentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Consumer<HomeController>(
          builder: (context, value, child) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Are you want to complete payment?',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const PaymentOptionContainer(),
              const Gap(16),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.primary.withOpacity(0.1),
                    ),
                    child: const Text(
                      "1,800 AED",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary),
                    ),
                  )),
                ],
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryElevateButton(
                    buttonName: "Cancel",
                    isGrey: false,
                    ontap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 10),
                  PrimaryElevateButton(
                      ontap: () {
                        Navigator.pop(context);
                      },
                      buttonName: "Proceed to payment"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
