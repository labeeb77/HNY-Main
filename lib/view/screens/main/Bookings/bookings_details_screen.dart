import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/data/models/booking/get_booking_list_model.dart';
import 'package:hny_main/view/screens/main/Bookings/widgets/complain_sheet.dart';
import 'package:hny_main/view/screens/main/Bookings/widgets/complete_payment_sheet.dart';
import 'package:hny_main/view/screens/main/bookings/payment_bottom_sheet.dart';

import 'package:intl/intl.dart';

class MyBookingDetailsScreen extends StatelessWidget {
  final BookingArrList bookingData;

  const MyBookingDetailsScreen({
    super.key,
    required this.bookingData,
  });

  @override
  Widget build(BuildContext context) {
    // Get car and add-ons from the booking items
    final carItems = bookingData.arrBookingItems
            ?.where((item) => item.type == ArrBookingItemType.CAR)
            .toList() ??
        [];
    final addOnItems = bookingData.arrBookingItems
            ?.where((item) => item.type == ArrBookingItemType.ADD_ON)
            .toList() ??
        [];

    return Scaffold(
      backgroundColor: Colors.grey[50], // AppColors.background equivalent
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Booking',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car Items
                  ...carItems
                      .map((item) => _buildVehicleCard(item, context ))
                      .toList(),

                  // Add-on Items
                  ...addOnItems.map((item) => _buildAddonCard(item)).toList(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(24),
              color: Colors.white,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBookingSummary(bookingData, context),
                  const SizedBox(height: 24),
                  _buildSupportSection(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard(ArrBookingItem carItem, context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 1),
            spreadRadius: 4,
            color: Colors.grey.shade200,
            blurRadius: 6,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Car image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 100,
                height: 134,
                child: Image.network(
                  carItem.strImgUrl ?? 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Car details
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getCarModel(carItem.strModel),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      InkWell(
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.deepOrange,
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              showPaymentSheet(context, carItem);
                            },
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'AED ${carItem.intTotalAmount?.floor() ?? 0}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  _buildDateRow(
                    _formatDate(carItem.strStartDate),
                    _formatDate(carItem.strEndDate),
                  ),
                  const SizedBox(height: 5),
                  _buildLocationRow(
                    _getLocationText(carItem.strPickupLocationAddress),
                    _getLocationText(carItem.strDeliveryLocationAddress),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Example of how to show this bottom sheet
  void showPaymentSheet(BuildContext context, carItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentBottomSheet(carItem: carItem,),
    );
  }

  Widget _buildAddonCard(ArrBookingItem addOnItem) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 1),
            spreadRadius: 4,
            color: Colors.grey.shade200,
            blurRadius: 6,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Add-on image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 100,
                height: 100,
                child: addOnItem.strImgUrl != null &&
                        addOnItem.strImgUrl!.isNotEmpty
                    ? Image.network(
                        addOnItem.strImgUrl!,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.image, size: 50, color: Colors.grey[400]),
              ),
            ),
            const SizedBox(width: 8),

            // Add-on details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        addOnItem.strName ?? addOnItem.strAddOnName ?? 'Add-on',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.deepOrange,
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Handle edit add-on
                          },
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'AED ${addOnItem.intTotalAmount?.floor() ?? 0}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Qty: ',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        '${addOnItem.intQty ?? 1}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRow(String startDate, String endDate) {
    log('start date : $startDate');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              startDate,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.arrow_forward,
            size: 15,
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 2,
            child: Text(
              endDate,
              style: const TextStyle(
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(String pickup, String dropoff) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Pickup location
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    pickup,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_forward,
            size: 15,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),

          // Dropoff location
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    dropoff,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingSummary(BookingArrList bookingData, context) {
    // Calculate total amount
    double totalAmount = 0;
    bookingData.arrBookingItems?.forEach((item) {
      totalAmount += item.intTotalAmount ?? 0;
    });

    // Get start and end dates from the first car item (if exists)
    final carItem = bookingData.arrBookingItems?.firstWhere(
      (item) => item.type == ArrBookingItemType.CAR,
      orElse: () => ArrBookingItem(),
    );
    final startDate = carItem?.strStartDate;
    final endDate = carItem?.strEndDate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Booking Summary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Download Invoice Button
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton.icon(
            onPressed: () {
              // Handle invoice download
            },
            icon: const Icon(Icons.download,
                color: Color.fromARGB(255, 59, 96, 60)),
            label: const Text(
              'Download Invoice',
              style: TextStyle(
                  color: Color.fromARGB(255, 46, 92, 47),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Booking Details
        _buildDetailRow(
            'Booking id', 'BK${bookingData.strBookingId ?? "00000"}'),
        const SizedBox(height: 16),

        _buildDetailRow('Start date', _formatDate(startDate)),
        const SizedBox(height: 16),

        _buildDetailRow('End date', _formatDate(endDate)),
        const SizedBox(height: 16),

        // Assuming 'Balance amount' is pending payment
        _buildDetailRow(
          'Balance amount',
          '${bookingData.intBalanceAmt ?? 1000} AED',
          valueColor: Colors.orange,
        ),
        const SizedBox(height: 16),

        _buildDetailRow(
          'Total amount',
          '${(totalAmount * 1.05).floor()} AED',
          valueStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 69, 106, 71),
          ),
        ),

        const SizedBox(height: 24),

        // Complete Payment Link
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => CompletePaymentSheet(),
            );
          },
          child: const Text(
            "Are you want to complete payment?",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Color? valueColor,
    TextStyle? valueStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: valueStyle ??
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black,
              ),
        ),
      ],
    );
  }

  Widget _buildSupportSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Column(
        children: [
          // Header with dropdown
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Need Help ?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: Colors.grey[700]),
              ],
            ),
          ),
          const Divider(height: 1),

          // Buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle support action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      "Support",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                    showModalBottomSheet(context: context, builder:(context) => ComplainBottomSheet(),);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      "Replacement",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('MMMM d, yyyy').format(date);
  }

  String _getCarModel(StrModel? model) {
    if (model == null) return 'Unknown Model';

    switch (model) {
      case StrModel.JAGUAR_100:
        return 'Jaguar 100';
      case StrModel.V8:
        return 'V8';
      default:
        return 'Unknown Model';
    }
  }

  String _getLocationText(String? location) {
    return location ?? 'Location not specified';
  }
}
