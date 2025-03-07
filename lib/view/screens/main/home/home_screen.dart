import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
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
                                      builder: (context) => SearchPage()),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
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
                    padding: EdgeInsets.all(16),
                    child: Consumer<HomeController>(
                      builder: (context, value, child) => Row(
                        children: [
                          DateSectionWidget(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                value.setSelectedStartDate(picked!);
                              },
                              value:
                                  value.selectedDateTOString ?? 'select Date',
                              title: "Start Date "),
                          SizedBox(width: 16),
                          DateSectionWidget(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null) {
                                  value.setSelectedEndtDate(picked);
                                }
                                if (value.selecteEnddDate != null &&
                                    value.selecteStratdDate != null) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Date"),
                                        content: Text(
                                            "Start Date: ${value.selectedDateTOString}\nEnd Date: ${value.selectedEndTOString}"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              var a = value.selecteStratdDate;
                                              var b = value.selecteEnddDate;
                                              log(a.toString(),
                                                  name: 'start date -----');
                                              log(b.toString(),
                                                  name: 'end date -----');
                                              value.getCarDataList(
                                                  context: context,
                                                  endDate:
                                                      value.selecteEnddDate,
                                                  startDate:
                                                      value.selecteStratdDate);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              value: value.selectedEndTOString ?? 'select date',
                              title: "End Date"),
                        ],
                      ),
                    ),
                  ),

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
                          return homeProvider.isLoading
                              ? CarCardSkeletonLoader(
                                  orientation: orientation,
                                  mediaQuery: MediaQuery.of(context),
                                  itemCount:
                                      3, // You can adjust this number as needed
                                )
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return buildCarCard(
                                      data[index],
                                      data[index].strModel ?? "Unknown",
                                      data[index].intRating.toString() ?? '4.0',
                                      data[index].strCarCategory ?? "Unknown",
                                      'Manual',
                                      data[index].intFuelCapacity.toString(),
                                      '${data[index].strSeatNo} Seats',
                                      data[index].intPricePerDay.toString(),
                                      data[index].strImgUrl ?? '',
                                      data[index].isFavourite ?? false,
                                      context,
                                      orientation,
                                      mediaQuery,
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
