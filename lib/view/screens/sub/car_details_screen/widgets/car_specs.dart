import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';

class CarSpecs extends StatelessWidget {
  const CarSpecs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SpecItem(icon: Icons.book_outlined, label: 'Manual'),
          SpecItem(icon: Icons.local_gas_station_outlined, label: 'Petrol'),
          SpecItem(icon: Icons.people_outlined, label: '5 Seats'),
          SpecItem(icon: Icons.speed_outlined, label: '138 bhp'),
          SpecItem(icon: Icons.water_drop_outlined, label: '470 litres'),
        ],
      ),
    );
  }
}

class SpecItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const SpecItem({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.greenShadeBackground,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            weight: 50,
            size: 20,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
