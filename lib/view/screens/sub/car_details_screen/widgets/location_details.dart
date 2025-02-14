
// Updated LocationDetails widget
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/view/screens/sub/location_picker_screen.dart';
import 'package:provider/provider.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(blurRadius: 0.8, spreadRadius: 0.1, color: Colors.grey)
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Icon(
                      Icons.circle_outlined,
                      color: Colors.green,
                    ),
                    SizedBox(
                        height: 80,
                        child: DottedLine(
                          dashLength: 8,
                          dashGapLength: 6,
                          direction: Axis.vertical,
                        )),
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.green,
                    ),
                  ],
                ),
                const Gap(16),
                SizedBox(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocationItem(
                        title: 'Pick-Up',
                        address: bookingProvider.pickupAddress,
                      ),
                      const Expanded(child: Divider()),
                      LocationItem(
                        title: 'Drop Off',
                        address: bookingProvider.dropoffAddress,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                  child: const FittedBox(
                    child: Row(
                      children: [
                        SizedBox(
                            height: 20,
                            width: 20,
                            child: Icon(
                              color: AppColors.white,
                              Icons.arrow_upward,
                            )),
                        SizedBox(
                            height: 20,
                            width: 20,
                            child: Icon(
                              Icons.arrow_downward,
                              color: AppColors.white,
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

// Updated LocationItem widget
class LocationItem extends StatelessWidget {
  final String title;
  final String address;

  const LocationItem({
    super.key,
    required this.title,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.push<String>(
          context,
          MaterialPageRoute(
            builder: (context) => LocationPickerScreen(
              from: title,
            ),
          ),
        );
        
        if (result != null) {
          context.read<BookingProvider>().updateLocation(title, result);
        }
      },
      child: Row(
        children: [
          Column(
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
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.85,
                child: Text(
                  address,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
