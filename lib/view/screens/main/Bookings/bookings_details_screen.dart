import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/screens/main/bookings/widgets/complain_sheet.dart';
import 'package:hny_main/view/screens/main/bookings/widgets/complete_payment_sheet.dart';
import 'package:hny_main/view/screens/sub/checkout_screen/widgets/random_widget.dart';
import 'package:hny_main/view/widgets/common_app_bar.dart';

class MyBookingDetailsScreen extends StatefulWidget {
  const MyBookingDetailsScreen({super.key});

  @override
  State<MyBookingDetailsScreen> createState() => _MyBookingDetailsScreenState();
}

class _MyBookingDetailsScreenState extends State<MyBookingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'My Booking',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildVehicleCard(
                    'Ford Escape',
                    'AED 5,000',
                    'https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_640.jpg',
                    'October 1, 2024',
                    'October 4, 2024',
                    'Nagavara, Bengaluru',
                    'Mentric Technology Park',
                  ),
                  const SizedBox(height: 16),
                  _buildVehicleCard(
                    'Hyundai Creta',
                    'AED 7,000',
                    'https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_640.jpg',
                    'October 5, 2024',
                    'October 10, 2024',
                    'Nagavara, Bengaluru',
                    'Mentric Technology Park',
                  ),
                  const SizedBox(height: 16),
                  buildAddonCard(
                      'Child Seat',
                      10,
                      'https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_640.jpg',
                      true),
                  const SizedBox(height: 16),
                  buildAddonCard(
                      'iPhone Charger',
                      10,
                      'https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_640.jpg',
                      true),
                ],
              ),
            ),
            const Gap(16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                      top: BorderSide(color: AppColors.containerBorderColor))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildBookingSummary(),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => const CompletePaymentSheet(),
                      );
                    },
                    child: const Text(
                      "Are you want to complete payment?",
                      style: TextStyle(
                          color: AppColors.blue,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color.fromARGB(255, 219, 219, 219)
                          .withOpacity(0.6),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Need Help?"),
                            Icon(Icons.keyboard_arrow_down_rounded)
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  builder: (context) => ComplainBottomSheet(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text(
                                "Support",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const Gap(12),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blue,
                              ),
                              child: const Text(
                                "Replacement",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard(
    String name,
    String price,
    String imagePath,
    String startDate,
    String endDate,
    String pickup,
    String dropoff,
  ) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                offset: Offset(1, 1),
                spreadRadius: 4,
                color: Color.fromARGB(255, 231, 231, 231),
                blurRadius: 6)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 100,
                height: 134,
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.orange,
                          child: IconButton(
                            icon: const Icon(Icons.edit,
                                size: 18, color: AppColors.white),
                            onPressed: () {},
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    buildDateRow(startDate, endDate),
                    buildLocationRow(pickup, dropoff),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
