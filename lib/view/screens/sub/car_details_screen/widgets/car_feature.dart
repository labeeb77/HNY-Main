import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:hny_main/data/models/favourites/favourites_model.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';

class CarFeatures extends StatelessWidget {
  final List<ArrCarFeature?> features;
  
  const CarFeatures({super.key, required this.features});

  List<StepperData> _getStepperData() {
    return features.map((feature) {
      return StepperData(
        title: StepperText(
          feature?.strFeatures ?? '',
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        ),
        subtitle: StepperText(
          feature?.strDescription ?? '',
          textStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 10,
          ),
        ),
        iconWidget: Container(
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
      );
    }).toList();
  }

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
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: AnotherStepper(
              stepperList: _getStepperData(),
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