import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:provider/provider.dart';

class DateTimeSelection extends StatelessWidget {
  const DateTimeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<BookingProvider, HomeController>(
      builder: (context, bookingProvider, homeController, child) {
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(blurRadius: 0.8, spreadRadius: 0.1, color: Colors.grey)
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 16.0),
                child: DateTimeItem(
                  title: 'Start Date & Time',
                  date: bookingProvider.formattedStartDate,
                  time: bookingProvider.formattedStartTime,
                  onTap: () {}
                  //  _selectDateTime(
                  //   context,
                  //   isStart: true,
                  //   bookingProvider: bookingProvider,
                  // ),
                ),
              ),
              const Divider(height: 32),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                child: DateTimeItem(
                  title: 'End Date & Time',
                  date: bookingProvider.formattedEndDate.toString(),
                  time: bookingProvider.formattedEndTime.toString(),
                  onTap: () {}
                  //  _selectDateTime(
                  //   context,
                  //   isStart: false,
                  //   bookingProvider: bookingProvider,
                  // ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDateTime(
    BuildContext context, {
    required bool isStart,
    required BookingProvider bookingProvider,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      if (context.mounted) {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) {
          if (isStart) {
            bookingProvider.updateStartDate(pickedDate);
            bookingProvider.updateStartTime(pickedTime);
          } else {
            bookingProvider.updateEndDate(pickedDate);
            bookingProvider.updateEndTime(pickedTime);
          }
        }
      }
    }
  }
}

// Updated DateTimeItem widget
class DateTimeItem extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final VoidCallback onTap;

  const DateTimeItem({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.calendar_today_outlined, size: 18),
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
      ),
    );
  }
}
