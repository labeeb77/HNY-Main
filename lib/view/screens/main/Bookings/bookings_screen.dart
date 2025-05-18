import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/models/booking/get_booking_list_model.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/view/screens/main/Bookings/bookings_details_screen.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initial load with "Upcoming" filter
      Provider.of<BookingProvider>(context, listen: false).getBookingList(
        context,
        filters: {
          "filters": {
            "strStatus": [
                        "SETTLED",
                        "COMPLETED",
                        "ISSUE",
                        "IN RENTAL",
                        "PENDING",
                        "CONFIRMED",
                        "CANCELLED"
                      ]
          }
        },
      );
       Provider.of<BookingProvider>(context, listen: false).updateActiveTab("All");  // Set "All" as default tab
    _handleTabChange("All");
    });
    super.initState();
  }

  // Method to handle tab changes
  // Method to handle tab changes
  void _handleTabChange(String tabName) {
    final provider = Provider.of<BookingProvider>(context, listen: false);
    provider.updateActiveTab(tabName);

    // Set appropriate filters based on tab
    Map<String, dynamic> filters = {
      "filters": {
        "strStatus": tabName == "Completed"
            ? ["SETTLED", "COMPLETED"]
            : (tabName == "In rental"
                ? ["ISSUE", "IN RENTAL"]
                : (tabName == "All"
                    ? [
                        "SETTLED",
                        "COMPLETED",
                        "ISSUE",
                        "IN RENTAL",
                        "PENDING",
                        "CONFIRMED",
                        "CANCELLED"
                      ]
                    : []))
      }
    };

    // Fetch bookings with the new filters
    provider.getBookingList(context, filters: filters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: Column(
              children: [
                const Gap(60),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      'My Booking',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Consumer<BookingProvider>(
                  builder: (context, provider, _) => Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 34, horizontal: 16),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 75, 124, 77)
                          .withOpacity(0.4),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        // All Tab
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _handleTabChange('All'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: provider.activeTab == 'All'
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: provider.activeTab == 'All'
                                    ? [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Text(
                                'All',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: provider.activeTab == 'All'
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Upcoming Tab
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _handleTabChange('Completed'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: provider.activeTab == 'Completed'
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: provider.activeTab == 'Completed'
                                    ? [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Text(
                                'Completed',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: provider.activeTab == 'Completed'
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // In rental Tab
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _handleTabChange('In rental'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: provider.activeTab == 'In rental'
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: provider.activeTab == 'In rental'
                                    ? [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Text(
                                'In rental',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: provider.activeTab == 'In rental'
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Remove "Completed" tab or add it back if needed
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Consumer<BookingProvider>(
              builder: (context, value, child) => value.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : value.bookingsListData.isEmpty
                      ? const Center(
                          child: Text('No bookings found'),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: value.bookingsListData.length,
                          itemBuilder: (context, index) {
                            return BookingCard(
                              index: index,
                              data: value.bookingsListData[index],
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final int index;
  final BookingArrList data;
  const BookingCard({super.key, required this.index, required this.data});

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.orange;
      case 'CONFIRMED':
        return Colors.blue;
      case 'IN RENTAL':
        return Colors.green;
      case 'COMPLETED':
        return Colors.green;
      case 'SETTLED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      case 'ISSUE':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, top: index == 0 ? 12 : 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          boxShadow: const [
            BoxShadow(
                offset: Offset(1, 1),
                spreadRadius: 0.1,
                color: Color.fromARGB(255, 225, 225, 225),
                blurRadius: 12)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top row with booking ID and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Booking ID
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Booking Id',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        data.strBookingId!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(data.strStatus ?? '').withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    data.strStatus ?? 'N/A',
                    style: TextStyle(
                      color: _getStatusColor(data.strStatus ?? ''),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Dates row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Start date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Trip Start',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        formatDateOnly(data.strStartDate.toString()),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
                // End date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Trip End',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        formatDateOnly(data.strEndDate.toString()),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          height: 1.1,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Bottom row with amounts and button
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Amounts section
                Expanded(
                  child: Row(
                    children: [
                      // Total amount
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${data.intTotalAmount?.floor()} AED',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Balance amount
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Balance',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${data.intBalanceAmt?.floor()} AED',
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // View Details button
                SizedBox(
                  width: 120,
                  height: 36,
                  child: PrimaryElevateButton(
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyBookingDetailsScreen(bookingId: data.id!)
                        ),
                      );
                    },
                    buttonName: "View Details",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDateOnly(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String month = _getMonthName(dateTime.month);
    String day = dateTime.day.toString();
    String year = dateTime.year.toString();
    String hour = dateTime.hour > 12 ? (dateTime.hour - 12).toString() : dateTime.hour.toString();
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String amPm = dateTime.hour >= 12 ? 'PM' : 'AM';
    
    return "$month $day $year\n$hour:$minute $amPm";
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
