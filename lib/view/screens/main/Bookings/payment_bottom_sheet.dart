import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/models/booking/get_booking_list_model.dart';
import 'package:hny_main/data/models/booking/reservation_item_details_model.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/view/screens/sub/location_picker_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentBottomSheet extends StatefulWidget {
  final ArrBookingItemTwo carItem;
  String bookingId;
  PaymentBottomSheet({Key? key, required this.carItem, required this.bookingId})
      : super(key: key);

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  int _selectedPaymentOption = 0;
  String? pickUpLocation;
  String? dropOffLocation;
  DateTime? selectedStartDate;
  TimeOfDay? selectedStartTime;
  DateTime? selectedEndDate;
  TimeOfDay? selectedEndTime;
  List<double>? pickupCoordinates;
  List<double>? dropoffCoordinates;
  bool _isLoading = false;

  final List<String> _paymentOptions = [
    'Pay Full Amount',
    'Pay Custom Amount',
  ];

  @override
  void initState() {
    pickUpLocation = widget.carItem.strPickupLocationAddress;
    dropOffLocation = widget.carItem.strDeliveryLocationAddress;
    selectedStartDate = widget.carItem.strStartDate;
    selectedEndDate = widget.carItem.strEndDate;
    super.initState();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('MMMM d, yyyy').format(date);
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return 'N/A';
    return time.format(context);
  }

  Future<void> _selectStartDate() async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = selectedStartDate ?? now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: selectedStartDate ?? now,
      lastDate: selectedEndDate ?? now.add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        selectedStartDate = picked;
      });
      await _selectStartTime();
    }
  }

  Future<void> _selectEndDate() async {
    if (selectedStartDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select start date first')),
      );
      return;
    }

    final DateTime initialDate =
        selectedEndDate ?? selectedStartDate!.add(const Duration(days: 1));

    // Validate dates before showing picker
    DateTime firstDate = selectedStartDate ?? DateTime.now();
    DateTime lastDate =
        selectedEndDate ?? DateTime.now().add(const Duration(days: 365));

    // Ensure lastDate is not before firstDate
    if (lastDate.isBefore(firstDate)) {
      lastDate = firstDate.add(const Duration(days: 365));
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        selectedEndDate = picked;
      });
      await _selectEndTime();
    }
  }

  Future<void> _selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedEndTime = picked;
      });
    }
  }

  Future<void> _handleDateUpdate() async {
    if (selectedStartDate == null ||
        selectedEndDate == null ||
        selectedStartTime == null ||
        selectedEndTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both date and time')),
      );
      return;
    }

    // Create DateTime objects with both date and time
    final DateTime startDateTime = DateTime(
      selectedStartDate!.year,
      selectedStartDate!.month,
      selectedStartDate!.day,
      selectedStartTime!.hour,
      selectedStartTime!.minute,
    );

    final DateTime endDateTime = DateTime(
      selectedEndDate!.year,
      selectedEndDate!.month,
      selectedEndDate!.day,
      selectedEndTime!.hour,
      selectedEndTime!.minute,
    );

    // Validate dates
    if (startDateTime.isAfter(endDateTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Start date must be before end date')),
      );
      return;
    }

    // Format dates for API
    final String formattedStartDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(startDateTime);
    final String formattedEndDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").format(endDateTime);

    try {
       await Provider.of<BookingProvider>(context, listen: false)
          .updateBookingDates(
        context,
        bookingId: widget.carItem.id!,
        startDate: formattedStartDate,
        endDate: formattedEndDate,
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating dates: $e')),
      );
    }
  }

  Future<void> _handleLocationUpdate() async {
    try {
      log(widget.bookingId.toString());
      if (pickUpLocation != widget.carItem.strPickupLocationAddress &&
          pickupCoordinates != null) {
      
            await Provider.of<BookingProvider>(context, listen: false)
                .updateBookingLocation(
          context,
          isPickup: true,
          bookingId: widget.bookingId,
          carId: widget.carItem.id!,
          coordinates: pickupCoordinates!,
          locationAddress: pickUpLocation ?? '',
        );
      }
      if (dropOffLocation != widget.carItem.strDeliveryLocationAddress &&
          dropoffCoordinates != null) {
       
            await Provider.of<BookingProvider>(context, listen: false)
                .updateBookingLocation(
          context,
          isPickup: false,
          bookingId: widget.bookingId,
          carId: widget.carItem.id!,
          coordinates: dropoffCoordinates!,
          locationAddress: dropOffLocation ?? '',
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating locations: $e')),
      );
    }
  }

  Future<void> _handleSubmit(String bookingID) async {
    if (_isLoading) return; // Prevent multiple submissions

    setState(() {
      _isLoading = true;
    });

    try {
      bool hasChanges = false;

      // Handle date updates
      if (selectedStartDate != null ||
          selectedEndDate != null ||
          selectedStartTime != null ||
          selectedEndTime != null) {
        await _handleDateUpdate();
        hasChanges = true;
      }

      // Handle location updates
      if (pickUpLocation != widget.carItem.strPickupLocationAddress ||
          dropOffLocation != widget.carItem.strDeliveryLocationAddress) {
        await _handleLocationUpdate();
        hasChanges = true;
      }

      // If no changes were made
      if (!hasChanges) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No changes to submit')),
        );
        return;
      }

      // Refresh data after successful updates
      await Provider.of<BookingProvider>(context, listen: false)
          .getReservationDetails(context, bookingId: widget.bookingId);
      await Provider.of<BookingProvider>(context, listen: false)
          .getBookingList(context);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Changes updated successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating changes: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
              _buildDateSection(
                  'Start Date & Time',
                  '${_formatDate(selectedStartDate)} ${_formatTime(selectedStartTime)}'),
              const Gap(12),
              _buildDateSection(
                  'End Date & Time',
                  '${_formatDate(selectedEndDate)} ${_formatTime(selectedEndTime)}'),
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
                pickupCoordinates = [updatedData['lat'], updatedData['long']];
              });
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
                dropoffCoordinates = [updatedData['lat'], updatedData['long']];
              });
            },
            child: _buildLocationSection(
              'Drop location',
              dropOffLocation ?? "",
            ),
          ),
          const SizedBox(height: 24),

          // Additional Amount

          // Amount Display

          // Action Buttons
          Row(
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
                  onPressed: _isLoading ? null : () => _handleSubmit(widget.bookingId),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Submit Changes',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(String title, String date) {
    return Expanded(
      child: InkWell(
        onTap: title.contains('Start') ? _selectStartDate : _selectEndDate,
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 8),
              const SizedBox(height: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.calendar_today,
                size: 20,
                color: Colors.grey[600],
              ),
            ],
          ),
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
