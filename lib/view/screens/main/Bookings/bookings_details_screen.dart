import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/data/models/booking/get_booking_list_model.dart';
import 'package:hny_main/data/models/booking/reservation_item_details_model.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/view/screens/main/Bookings/payment_bottom_sheet.dart';
import 'package:hny_main/view/screens/main/Bookings/widgets/complain_sheet.dart';
import 'package:hny_main/view/screens/main/Bookings/widgets/complete_payment_sheet.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyBookingDetailsScreen extends StatefulWidget {
  final String bookingId;
  const MyBookingDetailsScreen({
    super.key,
    required this.bookingId,
  });

  @override
  State<MyBookingDetailsScreen> createState() => _MyBookingDetailsScreenState();
}

class _MyBookingDetailsScreenState extends State<MyBookingDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Call getReservationDetails in initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
      bookingProvider.getReservationDetails(context, bookingId: widget.bookingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
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
      body: Consumer<BookingProvider>(
        builder: (context, bookingProvider, child) {
          if (bookingProvider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading booking details...'),
                ],
              ),
            );
          }

          if (bookingProvider.error != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      bookingProvider.error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        bookingProvider.getReservationDetails(
                          context,
                          bookingId: widget.bookingId,
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final bookingData = bookingProvider.reservationDetails;
          if (bookingData == null) {
            return const Center(
              child: Text('No booking details found'),
            );
          }

          // Get car and add-ons from the booking items
          final carItems = bookingData.arrBookingItems
                  ?.where((item) => item.type == "CAR")
                  .toList() ??
              [];
          final addOnItems = bookingData.arrBookingItems
                  ?.where((item) => item.type == "ADD_ON")
                  .toList() ??
              [];

          if (carItems.isEmpty) {
            return const Center(
              child: Text('No car items found in this booking'),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Car Items
                      ...carItems
                          .map((item) => _buildVehicleCard(
                                item,
                                item.reservArrCar?.firstOrNull ?? ReservArrCar(),
                                context,
                              ))
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
          );
        },
      ),
    );
  }

  Widget _buildVehicleCard(ArrBookingItemTwo carItem, ReservArrCar reservArrCar, context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 1),
            spreadRadius: 0.1,
            color: const Color.fromARGB(255, 225, 225, 225),
            blurRadius: 12,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Car image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 100,
                  child: Image.network(
                    reservArrCar.strImgUrl ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/placeholder_image.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Car details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "${reservArrCar.strBrand ?? ''} ${carItem.strModel ?? ''}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                                showPaymentSheet(context, carItem, widget.bookingId);
                              },
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'AED ${carItem.intTotalAmount?.toStringAsFixed(1) ?? '0.0'}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Trip Start
                    Row(
                      children: [
                        const Icon(Icons.calendar_month, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        const Text('Trip Start:', style: TextStyle(fontSize: 13, color: Colors.black)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _formatDate(carItem.strStartDate),
                            style: const TextStyle(fontSize: 12, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    // Trip End
                    Row(
                      children: [
                        const Icon(Icons.calendar_month, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        const Text('Trip End:', style: TextStyle(fontSize: 13, color: Colors.black)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _formatDate(carItem.strEndDate),
                            style: const TextStyle(fontSize: 12, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    // Location rows
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        const Text('Return:', style: TextStyle(fontSize: 13, color: Colors.black)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _getLocationText(carItem.strPickupLocationAddress),
                            style: const TextStyle(fontSize: 13, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        const Text('Drop-off:', style: TextStyle(fontSize: 13, color: Colors.black)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _getLocationText(carItem.strDeliveryLocationAddress),
                            style: const TextStyle(fontSize: 13, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Example of how to show this bottom sheet
  void showPaymentSheet(BuildContext context, carItem,bookingId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentBottomSheet(carItem: carItem, bookingId: bookingId)
    );
  }

  Widget _buildAddonCard(ArrBookingItemTwo addOnItem) {
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
                        "${addOnItem.strName}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // CircleAvatar(
                      //   radius: 14,
                      //   backgroundColor: Colors.deepOrange,
                      //   child: IconButton(
                      //     icon: const Icon(
                      //       Icons.edit,
                      //       size: 18,
                      //       color: Colors.white,
                      //     ),
                      //     onPressed: () {
                      //       // Handle edit add-on
                      //     },
                      //     constraints: const BoxConstraints(),
                      //     padding: EdgeInsets.zero,
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 8),

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

  Widget _buildBookingSummary(ReservationItemDetailsModel bookingData, context) {
    // Calculate total amount
    double totalAmount = 0;
    bookingData.arrBookingItems?.forEach((item) {
      totalAmount += item.intTotalAmount ?? 0;
    });

    // Calculate sum of additional charges
    double additionalCharges = 0;
    bookingData.arrAddCharges?.forEach((charge) {
      log('charge : ${charge.intAmount}');
      additionalCharges += charge.intAmount ?? 0;
    });

    // Get start and end dates from the first car item (if exists)
    final carItem = bookingData.arrBookingItems?.firstWhere(
      (item) => item.type == "CAR",
      orElse: () => ArrBookingItemTwo(),
    );
    final bookingId = bookingData.id;
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
            onPressed: () async {
              // Get the booking provider
              final bookingProvider = Provider.of<BookingProvider>(context, listen: false);

              // Call the download invoice method
              await bookingProvider.downloadInvoice(context, bookingId ?? "0");
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

        _buildDetailRow('Trip Start', _formatDate(startDate)),
        const SizedBox(height: 16),

        _buildDetailRow('Trip End', _formatDate(endDate)),
        const SizedBox(height: 16),
        _buildDetailRow('Additional Charges', '${additionalCharges.toStringAsFixed(2)} AED'),
        const SizedBox(height: 16),
        _buildDetailRow(
          'Paid amount',
          '${(double.parse(bookingData.intCheckoutAmount?.toStringAsFixed(2) ?? '0') - double.parse(bookingData.intBalanceAmt?.toStringAsFixed(2) ?? '0')).toStringAsFixed(2)} AED',
        ),
        const SizedBox(height: 16),

        // Assuming 'Balance amount' is pending payment
        _buildDetailRow(
          'Balance amount',
          '${bookingData.intBalanceAmt?.toStringAsFixed(2)} AED',
          valueColor: Colors.orange,
        ),
        const SizedBox(height: 16),

        _buildDetailRow(
          'Total amount',
          '${(bookingData.intCheckoutAmount ?? 0).toStringAsFixed(2)} AED',
          valueStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 69, 106, 71),
          ),
        ),

        const SizedBox(height: 24),

        // Complete Payment Link
        Visibility(
          visible: bookingData.intBalanceAmt != 0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => CompletePaymentSheet(
                  bookingId: bookingData.id ?? "",
                  strBookingId: bookingData.strBookingId ?? "",
                  balanceAmount: bookingData.intBalanceAmt ?? 0,
                ),
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
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => ComplainBottomSheet(),
                      );
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
    return DateFormat('MMMM d, yyyy hh:mm a').format(date);
  }

  String _getLocationText(String? location) {
    return location ?? 'Location not specified';
  }
}
