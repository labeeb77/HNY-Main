import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';
import 'package:provider/provider.dart';

class PriceRangeBottomSheet extends StatelessWidget {
  const PriceRangeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              'Price Range',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            RangeSlider(
              values: value.currentRangeValues,
              min: 0,
              max: 1000,
              divisions: 100,
              activeColor: AppColors.primary,
              inactiveColor: Colors.grey.shade200,
              labels: RangeLabels(
                'AED ${value.currentRangeValues.start.round()}',
                'AED ${value.currentRangeValues.end.round()}',
              ),
              onChanged: (RangeValues values) {
                value.changeSliderValue(values);
                log(value.currentRangeValues.toString());
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'AED ${value.currentRangeValues.start.round()}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'AED ${value.currentRangeValues.end.round()}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Car Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            value.isLoading
                ? const Center(child: CircularProgressIndicator())
                : // In your Wrap widget, update the children mapping:
                Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: value.carTypeListData.map((type) {
                      final isSelected = value.isCarTypeSelected(type);
                      return GestureDetector(
                        onTap: () {
                          value.toggleCarType(type);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? AppColors.primary : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Text(
                            type.strName ?? 'Unknown',
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 100),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  child: AppButton(
                    color: AppColors.primary,
                    onPressed: () {
                      value.clearCarTypes();
                      value.changeSliderValue(const RangeValues(30, 50));

                      Navigator.pop(context);
                    },
                    child: const AppText(
                      'Cancel',
                      color: AppColors.background,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppButton(
                    color: AppColors.primary,
                    onPressed: () {
                      value.filterCars();
                      Navigator.pop(context);
                    },
                    child: const AppText(
                      "Apply",
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
