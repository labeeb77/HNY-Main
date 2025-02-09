import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';

class CarSpecs extends StatelessWidget {
  final ArrCar arrCar;
  const CarSpecs({super.key, required this.arrCar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SpecItem(
            icon: Icons.book_outlined,
            label: arrCar.strVarients ?? 'N/A',
          ),
          SpecItem(
            icon: Icons.local_gas_station_outlined,
            label: arrCar.strFuelType?.toString() ?? 'N/A',
          ),
          SpecItem(
            icon: Icons.people_outlined,
            label: '${arrCar.strSeatNo ?? 'N/A'} Seats',
          ),
          SpecItem(
            icon: Icons.speed_outlined,
            label: '${arrCar.intPower ?? 'N/A'} bhp',
          ),
          SpecItem(
            icon: Icons.water_drop_outlined,
            label: '${arrCar.intFuelCapacity ?? 'N/A'} litres',
          ),
        ],
      ),
    );
  }
}


class SpecItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const SpecItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
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
