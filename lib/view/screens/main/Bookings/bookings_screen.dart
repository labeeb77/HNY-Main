import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/models/booking/get_booking_list_model.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/view/screens/main/bookings/bookings_details_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, top: index == 0 ? 16 : 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: AppColors.white,
          boxShadow: const [
            BoxShadow(
                offset: Offset(1, 1),
                spreadRadius: 0.1,
                color: Color.fromARGB(255, 225, 225, 225),
                blurRadius: 12)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Top row with booking ID and dates
            Row(
              children: [
                // Booking ID
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Booking Id',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.strBookingId!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Dates section
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Start date
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Start date',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatDateOnly(data.strStartDate.toString()),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      // End date
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'End date',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatDateOnly(data.strEndDate.toString()),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Bottom row with amounts and button
            Row(
              children: [
                // Amounts section
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Total amount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total amount',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${data.intTotalAmount?.floor()} AED',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      // Balance amount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Balance amount',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${data.intBalanceAmt?.floor()} AED',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // View Details button
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 30,
                    child: PrimaryElevateButton(
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyBookingDetailsScreen(
                              bookingData: data,
                            ),
                          ),
                        );
                      },
                      buttonName: "View Details",
                    ),
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
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }
}
