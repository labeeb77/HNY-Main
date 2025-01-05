import 'package:flutter/material.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(blurRadius: 0.8, spreadRadius: 0.1, color: Colors.grey)
        ],
        color: Colors.white,
        // color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left:16.0,right: 16.0,top: 16.0),
            child: DateTimeItem(
              title: 'Start Date & Time',
              date: 'October 1, 2024',
              time: '10:00 AM',
            ),
          ),
          Divider(
            height: 32,
          ),
          Padding(
            padding: EdgeInsets.only(left:16.0,right: 16.0,bottom: 16.0),
            child: DateTimeItem(
              title: 'End Date & Time',
              date: 'October 4, 2024',
              time: '10:00 AM',
            ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.calendar_today_outlined,size: 18,),
        const SizedBox(width: 32),
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
