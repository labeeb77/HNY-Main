import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:another_stepper/another_stepper.dart';

class CarFeatures extends StatelessWidget {
  CarFeatures({super.key});

  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Info Time System",
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        ),
        subtitle: StepperText(
          "Seamlessly designed with SYNC® 4, Navigation, Voice Recognition, and Real-Time Traffic Updates.",
          textStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 10,
          ),
        ),
        iconWidget: Container(
          decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(30))),
        )),
    StepperData(
        title: StepperText("Apple Play Support",
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
        subtitle: StepperText(
          "Effortlessly integrates with Apple CarPlay®, offering hands-free calls, maps, music, and Siri® voice control.",
          textStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 10,
          ),
        ),
        iconWidget: Container(
          decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(30))),
        )),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Features',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const SizedBox(height: 16),
          // const FeatureItem(
          //   title: 'Info Time System',
          //   description:
          //       'Seamlessly designed with SYNC® 4, Navigation, Voice Recognition, and Real-Time Traffic Updates.',
          // ),
          // const FeatureItem(
          //   title: 'Apple Play Support',
          //   description:
          //       'Effortlessly integrates with Apple CarPlay®, offering hands-free calls, maps, music, and Siri® voice control.',
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: AnotherStepper(
              stepperList: stepperData,
              stepperDirection: Axis.vertical,
              iconWidth: 10,
              iconHeight: 10,
              activeBarColor: AppColors.primary,
              inActiveBarColor: Colors.grey,
              inverted: false,
              verticalGap: 40,
              activeIndex: 1,
              barThickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String title;
  final String description;

  const FeatureItem({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 10),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
