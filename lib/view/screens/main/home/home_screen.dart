import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/home_controller.dart';
import 'package:hny_main/view/screens/main/home/filter_bottomsheet.dart';
import 'package:hny_main/view/screens/main/home/widgets_elements.dart';
import 'package:hny_main/view/screens/main/profile/add_profile_screen.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemStatusBarContrastEnforced: false,
        statusBarColor: AppColors.primary, // Match your app bar color
        statusBarIconBrightness:
            Brightness.light, // Adjust icons for visibility
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((va) {
      final homeController =
          Provider.of<HomeController>(context, listen: false);
      homeController.getCarDataList(context);
      homeController.getCarTypeList(); // Add this to fetch car types
    });
    super.initState();
  }

  String getImageUrlForType(String type) {
    switch (type.toLowerCase()) {
      case 'sedan':
        return 'https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_640.jpg';
      case 'suv':
        return 'https://static.vecteezy.com/system/resources/thumbnails/031/196/761/small_2x/beautiful-modern-concept-supercar-light-sky-blue-with-maroon-details-photo.jpg';
      default:
        return 'https://cdn.pixabay.com/photo/2012/05/29/00/43/car-49278_640.jpg';
    }
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
          ),
          const Gap(
            24,
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              "LOCATION",
              fontSize: 12,
              color: AppColors.white,
            ),
            Gap(4),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.place,
                    size: 18,
                    color: AppColors.white,
                  ),
                ),
                AppText(
                  "New York, USA",
                  fontSize: 16,
                  color: AppColors.textwhiteSecondary,
                  fontWeight: FontWeight.w500,
                )
              ],
            )
          ],
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
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search "Tata"',
                              border: InputBorder.none,
                              // hintStyle:
                              //     TextStyle(color: Colors.grey[400]),
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
            // Date Selection Section
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        DateSectionWidget(
                            value: 'October 1, 2024',
                            title: "Start Date & Time"),
                        SizedBox(width: 16),
                        DateSectionWidget(
                            value: 'October 4, 2024', title: "End Date"),
                      ],
                    ),
                  ),

                  // Ride Options Section
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
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeController.carTypeListData.length +
                                1, // +1 for "View All"
                            itemBuilder: (context, index) {
                              // If it's the last item, show "View All"
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
                                child: buildRideOption(
                                  getImageUrlForType(carType.strType ?? ''),
                                  carType.strName ?? 'Unknown',
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
                          onTap: () {
                            
                          },
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
                          Consumer<HomeController>(
                        builder: (context, value, child) {
                          final data = value.carListData;
                          log('car items length: ${value.carListData.length}');
                          return value.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: value.carListData.length,
                                  itemBuilder: (context, index) => buildCarCard(
                                    data[index],
                                      data[index].strModel ?? "Unknown",
                                      data[index].intRating.toString() ?? '4.0',
                                      data[index].strCarCategory ?? "Unknown",
                                      'Manual',
                                      data[index].intFuelCapacity ?? "Unknown",
                                      '${data[index].strSeatNo} Seats',
                                      data[index].intPricePerDay.toString(),
                                      data[index].strImgUrl!,
                                      false,
                                      context,
                                      orientation,
                                      mediaQuery));
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
