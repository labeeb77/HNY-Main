import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/data/providers/booking_provider.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/car_details_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeController = Provider.of<HomeController>(context, listen: false);
      homeController.getCarDataList(context: context);
      homeController.getCarTypeList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 120,
        backgroundColor: AppColors.primary,
        title: Consumer<HomeController>(
          builder: (context, value, child) => TextField(
            onChanged: (query) {
              value.searchFeilds(query);
              value.getCarDataList(
                  context: context, 
                  search: query.toLowerCase(),
                  startDate: value.selecteStratdDate,
                  endDate: value.selecteEnddDate,
              );
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search...',
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ),
      body: Consumer<HomeController>(
        builder: (context, value, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    DateSectionWidget(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: value.selecteStratdDate ?? DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          value.setSelectedStartDate(picked);
                          if (value.selecteEnddDate != null) {
                            value.getCarDataList(
                              context: context,
                              endDate: value.selecteEnddDate,
                              startDate: value.selecteStratdDate,
                            );
                          }
                        }
                      },
                      value: value.selectedDateTOString ?? 'Select Date',
                      title: "Start Day",
                    ),
                    const SizedBox(width: 16),
                    DateSectionWidget(
                      onTap: () async {
                        DateTime initialDate = value.selecteStratdDate != null
                            ? value.selecteStratdDate!.add(const Duration(days: 1))
                            : DateTime.now();

                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: initialDate,
                          firstDate: value.selecteStratdDate ?? DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          value.setSelectedEndtDate(picked);
                          if (value.selecteStratdDate != null) {
                            value.getCarDataList(
                              context: context,
                              endDate: value.selecteEnddDate,
                              startDate: value.selecteStratdDate,
                            );
                          }
                        }
                      },
                      value: value.selectedEndTOString ?? 'Select Date',
                      title: "End Day",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: value.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : value.carListData.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions_car_outlined,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 10),
                                Text('No Available Cars'),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: value.carListData.length,
                            itemBuilder: (context, index) {
                              final data = value.carListData[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      offset: const Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(12)),
                                      child: CachedNetworkImage(
                                        imageUrl: data.strImgUrl ?? '',
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(
                                          color: Colors.grey[300],
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          color: Colors.grey[300],
                                          child: const Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            "${data.strBrand} ${data.strModel}",
                                            
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Gap(10),
                                          Row(
                                            children: [
                                              AppText(
                                                '${data.intPricePerDay} AED',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange,
                                                fontSize: 16,
                                              ),
                                              const AppText(
                                                ' / day',
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                          const Gap(10),
                                          Container(
                                            height: 20,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: const Color.fromARGB(
                                                  255, 199, 225, 247),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                AppText(
                                                  value.selectedDateTOString ??
                                                      'Select Date',
                                                  fontSize: 10,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                const Icon(Icons.arrow_right_alt),
                                                AppText(
                                                  value.selectedEndTOString ??
                                                      'Select Date',
                                                  fontSize: 10,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Gap(5),
                                          Consumer<BookingProvider>(
                                            builder: (context, bookingProvider, child) {
                                              final priceCalculation = bookingProvider.calculateTotalPrice(
                                                dailyRate: data.intPricePerDay ?? 0,
                                                weeklyRate: data.intPricePerWeek ?? 0,
                                                monthlyRate: data.intPricePerMonth ?? 0,
                                              );
                                              
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      AppText(
                                                        'Total Price',
                                                        fontSize: 14,
                                                      ),
                                                      AppText(
                                                        '${priceCalculation.totalPrice.toStringAsFixed(2)} AED',
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.orange,
                                                        fontSize: 16,
                                                      ),
                                                    ],
                                                  ),
                                                  const Gap(5),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: value.selecteStratdDate != null && value.selecteEnddDate != null
                                                                ? AppColors.primary
                                                                : Colors.grey,
                                                          ),
                                                          onPressed: value.selecteStratdDate != null && value.selecteEnddDate != null
                                                              ? () {
                                                                  Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) => CarDetailsScreen(
                                                                        arrCar: data,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              : null,
                                                          child: const AppText(
                                                            'Book Now',
                                                            color: AppColors.background,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DateSectionWidget extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const DateSectionWidget({
    required this.title,
    required this.value,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.calendar_month,
                size: 18,
              ),
              const Gap(14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
