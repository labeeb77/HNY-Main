import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/favourite_provider.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/screens/Search/search.dart';
import 'package:hny_main/view/screens/main/home/filter_bottomsheet.dart';
import 'package:hny_main/view/screens/main/home/widgets_elements.dart';
import 'package:hny_main/view/widgets/car_card_loader.dart';
import 'package:hny_main/view/widgets/ride_option_loader.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: false,
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((va) {
      final homeController =
          Provider.of<HomeController>(context, listen: false);
      homeController.getCarDataList(context: context);
      homeController.getCarTypeList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          CircledIcon(
            circleColor: AppColors.circleAvatarBackground,
            iconColor: AppColors.white,
            badgeValue: "2",
            icon: Icons.notifications_outlined,
          ),
          const Gap(
            12,
          ),
          CircledIcon(
            circleColor: AppColors.circleAvatarBackground,
            iconColor: AppColors.white,
            badgeValue: "2",
            icon: Icons.shopping_cart_outlined,
            ontap: () => Navigator.pushNamed(context, AppRoutes.myCartPage),
          ),
          const Gap(
            24,
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/icons/menu-svgrepo-com-2.svg",
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 13),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.search, color: Colors.grey),
                        const SizedBox(width: 8),
                        Consumer<HomeController>(
                          builder: (context, value, child) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SearchPage()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Search "Tata"',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.mic, color: Colors.grey),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(9),
                CircledIcon(
                  ontap: () {
                    Provider.of<HomeController>(context, listen: false)
                        .getCarDataList(context: context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => const PriceRangeBottomSheet(),
                    );
                  },
                  circleColor: AppColors.white,
                  iconColor: AppColors.iconGrey,
                  badgeValue: "1",
                  icon: Icons.filter_alt_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 32,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: AppColors.primary,
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Consumer<HomeController>(
                        builder: (context, value, child) => Row(
                          children: [
                            DateSectionWidget(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      value.selecteStratdDate ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null) {
                                  // Show time picker after date is selected
                                  final TimeOfDay? pickedTime =
                                      await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );

                                  if (pickedTime != null) {
                                    // Combine date and time
                                    final DateTime selectedDateTime = DateTime(
                                      picked.year,
                                      picked.month,
                                      picked.day,
                                      pickedTime.hour,
                                      pickedTime.minute,
                                    );
                                    value
                                        .setSelectedStartDate(selectedDateTime);

                                    // If both dates are selected, automatically apply the filter
                                    if (value.selecteEnddDate != null) {
                                      value.getCarDataList(
                                          context: context,
                                          endDate: value.selecteEnddDate,
                                          startDate: value.selecteStratdDate);
                                    }
                                  }
                                }
                              },
                              value:
                                  value.selectedDateTOString ?? 'Select Date',
                              title: "Start Date",
                            ),
                            const SizedBox(width: 16),
                            DateSectionWidget(
                              onTap: () async {
                                // Set minimum date to start date if selected
                                DateTime initialDate =
                                    value.selecteStratdDate != null
                                        ? value.selecteStratdDate!
                                            .add(Duration(days: 1))
                                        : DateTime.now();

                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: initialDate,
                                  firstDate:
                                      value.selecteStratdDate ?? DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null) {
                                  // Show time picker after date is selected
                                  final TimeOfDay? pickedTime =
                                      await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );

                                  if (pickedTime != null) {
                                    // Combine date and time
                                    final DateTime selectedDateTime = DateTime(
                                      picked.year,
                                      picked.month,
                                      picked.day,
                                      pickedTime.hour,
                                      pickedTime.minute,
                                    );
                                    value.setSelectedEndtDate(selectedDateTime);

                                    // Only show dialog and apply filter if both dates are selected
                                    if (value.selecteStratdDate != null) {
                                      // Apply filter directly without showing dialog
                                      value.getCarDataList(
                                          context: context,
                                          endDate: value.selecteEnddDate,
                                          startDate: value.selecteStratdDate);
                                    }
                                  }
                                }
                              },
                              value: value.selectedEndTOString ?? 'Select Date',
                              title: "End Date",
                            ),
                          ],
                        ),
                      )),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Ride options',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<HomeController>(
                    builder: (context, homeController, child) {
                      if (homeController.isLoading) {
                        return const HorizontalRideOptionsLoader(itemCount: 6);
                      }

                      return SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                homeController.carTypeListData.length + 1,
                            itemBuilder: (context, index) {
                              if (index ==
                                  homeController.carTypeListData.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: buildRideOption('', 'View All'),
                                );
                              }

                              final carType =
                                  homeController.carTypeListData[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // Call getCarDataList with the car type name as search parameter
                                    Provider.of<HomeController>(context,
                                            listen: false)
                                        .getCarDataList(
                                      context: context,
                                      search: carType.strName,
                                    );
                                  },
                                  child: buildRideOption(
                                    carType.strImgUrl ??
                                        'assets/images/placeholder_image.webp',
                                    carType.strName ?? 'Unknown',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),

                  // Popular Cars Section
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Cars',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              color: Color(0xFF0B5D3A),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Car Cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: OrientationBuilder(
                      builder: (context, orientation) =>
                          Consumer2<HomeController, FavouriteProvider>(
                        builder: (context, homeProvider, favProvider, child) {
                          final data = homeProvider.carListData;
                          log('car items length: ${homeProvider.carListData.length}');

                          // Check if both dates are selected
                          bool areDatesSelected =
                              homeProvider.selecteStratdDate != null &&
                                  homeProvider.selecteEnddDate != null;

                          return homeProvider.isLoading
                              ? CarCardSkeletonLoader(
                                  orientation: orientation,
                                  mediaQuery: MediaQuery.of(context),
                                  itemCount:
                                      3, // You can adjust this number as needed
                                )
                              : homeProvider.carListData.isEmpty
                                  ? const Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                      ),
                                    )
                                  : ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return buildCarCard(
                                          data[index],
                                          data[index].strBrand ?? "Unknown",
                                          data[index].strModel ?? "Unknown",
                                          data[index].intRating.toString() ??
                                              '4.0',
                                          data[index].strCarCategory?.name ??
                                              "Unknown",
                                          'Manual',
                                          data[index]
                                              .intFuelCapacity
                                              .toString(),
                                          '${data[index].strSeatNo} Seats',
                                          data[index].intPricePerDay.toString(),
                                          data[index].strImgUrl ?? '',
                                          data[index].isFavourite ?? false,
                                          context,
                                          orientation,
                                          mediaQuery,
                                          datesSelected:
                                              areDatesSelected, // Pass the date selection status
                                          onFavoriteTap: () {
                                            favProvider
                                                .addToFavourites(
                                                    data[index].id ?? '0')
                                                .then((_) {
                                              homeProvider.getCarDataList(
                                                  context: context);
                                            });
                                          },
                                        );
                                      });
                        },
                      ),
                    ),
                  ),
                  const Gap(24)
                ],
              ),
            )
          ],
        ),
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
