import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/models/favourites/favourites_model.dart';
import 'package:hny_main/data/models/response/car_list_model.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/car_details_screen.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';

import 'dart:math' as math;

class NavItemWidget extends StatelessWidget {
  final bool isSelected;
  final String label;
  final IconData icon;
  final VoidCallback ontap;
  final Orientation orientation;

  const NavItemWidget({
    Key? key,
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.ontap,
    required this.orientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isPortrait = orientation == Orientation.portrait;

    // Calculate dynamic sizes
    final double iconSize = isPortrait
        ? math.min(24, screenSize.width * 0.06)
        : math.min(20, screenSize.height * 0.06);

    final double fontSize = isPortrait
        ? math.min(12, screenSize.width * 0.03)
        : math.min(10, screenSize.height * 0.03);

    return InkWell(
      onTap: ontap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : Colors.grey,
            size: iconSize,
          ),
          if (isPortrait ||
              screenSize.width >
                  600) // Show label in portrait or wide landscape
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.grey,
                fontSize: fontSize,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
        ],
      ),
    );
  }
}

Widget buildFeature(IconData icon, dynamic label) {
  return Row(
    children: [
      Icon(
        icon,
        size: 20,
        color: AppColors.white,
      ),
      const SizedBox(width: 4),
      Text(
        label.toString(),
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 14,
        ),
      ),
    ],
  );
}

Widget buildCarCard(
  ArrCar arrCar,
  String name,
  String rating,
  String category,
  String transmission,
  String fuelType,
  String seats,
  String price,
  String image,
  bool isFromFav,
  context,
  orientation,
  mediaQuery, {
  required VoidCallback onFavoriteTap,
}) {
  log('isFromFave :$isFromFav');
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarDetailsScreen(
              arrCar: arrCar,
            ),
          ));
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(1, 1))
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: orientation == Orientation.portrait
                    ? mediaQuery.height / 4.5
                    : mediaQuery.width /
                        4.5, // Explicitly use 500 for landscape
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: orientation == Orientation.portrait
                          ? mediaQuery.height / 4.5
                          : mediaQuery.width / 4.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: image.isNotEmpty
                          ? Image(
                              image: CachedNetworkImageProvider(image),
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/placeholder_image.webp',
                              fit: BoxFit.cover,
                            ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.2),
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.9),
                            ]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12, top: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  if (rating != null && rating != 'null') ...[
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.star,
                                              color: Colors.amber, size: 14),
                                          const SizedBox(width: 4),
                                          Text(
                                            rating.toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(12),
                                  ],
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.orange,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      category,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: CircledIcon(
                                  ontap: onFavoriteTap,
                                  circleColor: isFromFav
                                      ? AppColors.favoriteColor
                                      : AppColors.circleAvatarBackground,
                                  iconColor: AppColors.white,
                                  icon: Icons.favorite_border_outlined,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildFeature(Icons.settings, transmission),
                              buildFeature(Icons.local_gas_station, fuelType),
                              buildFeature(Icons.people, seats),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '$price AED',
                          style: TextStyle(
                            color: isFromFav ? AppColors.orange : Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(4),
                        const Text(
                          '/ day',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                 PrimaryElevateButton(ontap: () {
                   Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarDetailsScreen(
              arrCar: arrCar,
            ),
          ));
                },),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildFavCarCard(
  FavArrList arrCar,
  String name,
  String rating,
  String category,
  String transmission,
  dynamic fuelType,
  String seats,
  String price,
  String image,
  bool isFromFav,
  context,
  orientation,
  mediaQuery, {
  required VoidCallback onFavoriteTap,
}) {
  log('isFromFave :$isFromFav');
  return InkWell(
    onTap: () {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => CarDetailsScreen(
      //         arrCar: arrCar,
      //       ),
      //     ));
    },
    child: Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(1, 1))
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: orientation == Orientation.portrait
                    ? mediaQuery.height / 4.5
                    : mediaQuery.width /
                        4.5, // Explicitly use 500 for landscape
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: orientation == Orientation.portrait
                          ? mediaQuery.height / 4.5
                          : mediaQuery.width / 4.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image(
                        image: CachedNetworkImageProvider(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.2),
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.9),
                            ]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12, top: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  if (rating != null && rating != 'null') ...[
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.star,
                                              color: Colors.amber, size: 14),
                                          const SizedBox(width: 4),
                                          Text(
                                            rating.toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(12),
                                  ],
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.orange,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      category,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: CircledIcon(
                                  ontap: onFavoriteTap,
                                  circleColor: isFromFav
                                      ? AppColors.favoriteColor
                                      : AppColors.circleAvatarBackground,
                                  iconColor: AppColors.white,
                                  icon: Icons.favorite_border_outlined,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildFeature(Icons.settings, transmission),
                              buildFeature(Icons.local_gas_station, fuelType),
                              buildFeature(Icons.people, seats),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '$price AED',
                          style: TextStyle(
                            color: isFromFav ? AppColors.orange : Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(4),
                        const Text(
                          '/ day',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const PrimaryElevateButton(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildRideOption(String image, String label) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(4),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(1, 1))
          ],
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: image.isEmpty
            ? const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
                size: 16,
              )
            : CachedNetworkImage(
                placeholder: (context, url) => Icon(
                  Icons.image_outlined,
                  color: Colors.grey.withOpacity(0.5),
                ),
                imageUrl: image,
              ),
      ),
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 120, 120, 120),
        ),
      ),
    ],
  );
}

class CircledIcon extends StatelessWidget {
  final Color? circleColor;
  final Color? iconColor;
  final IconData? icon;
  final String? badgeValue;
  final VoidCallback? ontap;

  const CircledIcon({
    this.circleColor,
    this.ontap,
    this.icon,
    this.badgeValue,
    this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: badgeValue != null,
      label: Text(badgeValue ?? ""),
      backgroundColor: AppColors.orange,
      child: InkWell(
        onTap: ontap ?? () {},
        borderRadius:
            BorderRadius.circular(50), // Adds ripple effect inside circle
        child: CircleAvatar(
          backgroundColor: circleColor,
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

class DateSectionWidget extends StatelessWidget {
  final title;
  final value;
  final VoidCallback onTap;

  const DateSectionWidget({
    this.title,
    this.value,
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
                    offset: const Offset(1, 1))
              ]),
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
                  Text(
                    title,
                  ),
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
