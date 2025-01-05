import 'package:flutter/material.dart';

class CarSpecs extends StatelessWidget {
  const CarSpecs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SpecItem(icon: Icons.book, label: 'Manual'),
          SpecItem(icon: Icons.local_gas_station, label: 'Petrol'),
          SpecItem(icon: Icons.people, label: '5 Seats'),
          SpecItem(icon: Icons.speed, label: '138 bhp'),
          SpecItem(icon: Icons.water_drop, label: '470 litres'),
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
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
