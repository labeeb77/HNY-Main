import 'package:flutter/material.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: const [
          LocationItem(
            title: 'Pick-Up',
            address: '22 Street, 59, Al Quoz Industrial 2',
            isPickup: true,
          ),
          SizedBox(height: 16),
          LocationItem(
            title: 'Drop Off',
            address: '567R+876 - 4th St - Al Quoz',
            isPickup: false,
          ),
        ],
      ),
    );
  }
}

class LocationItem extends StatelessWidget {
  final String title;
  final String address;
  final bool isPickup;

  const LocationItem({
    Key? key,
    required this.title,
    required this.address,
    required this.isPickup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isPickup ? Icons.circle_outlined : Icons.location_on_outlined,
          color: Colors.green,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                address,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}