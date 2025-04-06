import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/models/booking/get_booking_list_model.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/view/screens/sub/location_picker_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentBottomSheet extends StatefulWidget {
  final ArrBookingItem carItem;
  const PaymentBottomSheet({Key? key, required this.carItem}) : super(key: key);

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  int _selectedPaymentOption = 0;
  String? pickUpLocation;
  String? dropOffLocation;

  final List<String> _paymentOptions = [
    'Pay Minimum Amount',
    'Pay Full Amount',
    'Pay Custom Amount',
  ];
  @override
  void initState() {
    pickUpLocation = widget.carItem.strPickupLocationAddress;
    dropOffLocation = widget.carItem.strDeliveryLocationAddress;

    super.initState();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('MMMM d, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDateSection('Start Date & Time',
                  _formatDate(widget.carItem.strStartDate)),
              const Gap(12),
              _buildDateSection(
                'End Date & Time',
                _formatDate(widget.carItem.strEndDate),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Pickup Location
          InkWell(
            onTap: () async {
              final updatedData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const LocationPickerScreen(from: "Pick-Up"),
                  ));
              log(updatedData.toString());
              setState(() {
                pickUpLocation = updatedData['address'];
              });
              final success =
                  await Provider.of<BookingProvider>(context, listen: false)
                      .updateBooking(
                context,
                bookingId: widget.carItem.id!,
                coordinates: [updatedData['lat'], updatedData['long']],
                isPickup: true,
                locationAddress: updatedData['address'],
              );
              if (success) {
                final provider =
                    Provider.of<BookingProvider>(context, listen: false);
                Provider.of<BookingProvider>(context, listen: false)
                    .getBookingList(context, filters: {
                  "filters": {
                    "strStatus": provider.activeTab == "Upcoming"
                        ? ["SETTLED", "COMPLETED"]
                        : (provider.activeTab == "In rental"
                            ? ["ISSUE", "IN RENTAL"]
                            : [])
                  }
                });
              }
            },
            child: _buildLocationSection(
              'Pickup location',
              pickUpLocation ?? "",
            ),
          ),
          const SizedBox(height: 24),

          // Drop Location
          InkWell(
            onTap: () async {
              final updatedData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const LocationPickerScreen(from: "Drop Off"),
                  ));
              log(updatedData.toString());
              setState(() {
                dropOffLocation = updatedData['address'];
                ;
              });
              final success =
                  await Provider.of<BookingProvider>(context, listen: false)
                      .updateBooking(
                context,
                bookingId: widget.carItem.id!,
                coordinates: [updatedData['lat'], updatedData['long']],
                isPickup: false,
                locationAddress: updatedData['address'],
              );
              if (success) {
                final provider =
                    Provider.of<BookingProvider>(context, listen: false);

                Provider.of<BookingProvider>(context, listen: false)
                    .getBookingList(context, filters: {
                  "filters": {
                    "strStatus": provider.activeTab == "Upcoming"
                        ? ["SETTLED", "COMPLETED"]
                        : (provider.activeTab == "In rental"
                            ? ["ISSUE", "IN RENTAL"]
                            : [])
                  }
                });
              }
            },
            child: _buildLocationSection(
              'Drop location',
              dropOffLocation ?? "",
            ),
          ),
          const SizedBox(height: 24),

          // Additional Amount
          Text(
            'Additional amount AED 30',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange[400],
            ),
          ),
          const SizedBox(height: 24),

          // Payment Options
          ...List.generate(
            _paymentOptions.length,
            (index) => _buildPaymentOption(index),
          ),
          const SizedBox(height: 16),

          // Amount Display
          Container(
            height: 45,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '30 AED',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                  child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Pay now',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(String title, String date) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 8),
            const SizedBox(height: 4),
            Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection(String title, String location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  location,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Icon(
                Icons.location_on,
                color: Colors.green[800],
                size: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentOption = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _selectedPaymentOption == index
                      ? Colors.green[800]!
                      : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: _selectedPaymentOption == index
                  ? Center(
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[800],
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              _paymentOptions[index],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
