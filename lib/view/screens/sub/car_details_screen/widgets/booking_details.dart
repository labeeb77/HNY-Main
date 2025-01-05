import 'package:flutter/material.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: const [
          DateTimeItem(
            title: 'Start Date & Time',
            date: 'October 1, 2024',
            time: '10:00 AM',
          ),
          SizedBox(height: 16),
          DateTimeItem(
            title: 'End Date & Time',
            date: 'October 4, 2024',
            time: '10:00 AM',
          ),
        ],
      ),
    );
  }
}

class DateTimeItem extends StatelessWidget {
  final String title;
  final String date;
  final String time;

  const DateTimeItem({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.calendar_today_outlined),
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
              Row(
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}