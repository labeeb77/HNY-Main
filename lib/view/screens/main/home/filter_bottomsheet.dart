import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/widgets/app_button.dart';
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
        builder: (context, value, child) => 
         Column(
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
            
              max: 100,
              divisions: 100,
              activeColor: AppColors.primary,
              inactiveColor: Colors.grey.shade200,
              labels: RangeLabels(
                'AED ${value.currentRangeValues.start.round()}',
                'AED ${value.currentRangeValues.end.round()}',
              ),
              onChanged: (RangeValues values) {
              value.changeSliderValue(values);
              },
            ),
           Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: value.carTypes.map((type) {
                final isSelected = value.selectedCarType == type;
                return GestureDetector(
                  onTap: () {
                    value.changeCarType(type);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      type,
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
                Spacer()
,                 Expanded(
                  child: PrimaryElevateButton(
                    buttonName: "Clear All",isGrey: true,
                  ontap: (){
                    Navigator.pop(context);
                  },
                  ),
                ),
                const SizedBox(width: 10),
                 Expanded(
                  child: PrimaryElevateButton(
                     ontap: (){
                    Navigator.pop(context);
                  },
                    buttonName:"Apply"
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}