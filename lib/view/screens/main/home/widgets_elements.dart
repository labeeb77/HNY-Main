import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/view/screens/sub/car_details_screen/car_details_screen.dart';
import 'package:hny_main/view/widgets/app_button.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';

class NavItemWidget extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final VoidCallback ontap;
  final orientation;

  const NavItemWidget({
    required this.isSelected,
    required this.icon,
    required this.ontap,
    required this.label,
    required this.orientation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Fixed height for the indicator
            SizedBox(
              height: 2,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isSelected ? MediaQuery.of(context).size.width / 6 : 0,
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
            ),

            const SizedBox(height: 6),
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            orientation == Orientation.portrait
                ? Column(
                    children: [
                      const SizedBox(height: 4),
                      AppText(
                        label,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w400,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}

Widget buildFeature(IconData icon, String label) {
  return Row(
    children: [
      Icon(
        icon,
        size: 20,
        color: AppColors.white,
      ),
      const SizedBox(width: 4),
      Text(
        label,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 14,
        ),
      ),
    ],
  );
}

Widget buildCarCard(
  String name,
  double rating,
  String category,
  String transmission,
  String fuelType,
  String seats,
  String price,
  String image,
  bool isFromFav,
  context,
  orientation,
  mediaQuery,
) {
  return InkWell(
    onTap: () {
      log('Car Details');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CarDetailsScreen(),
          ));
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
                  // image: DecorationImage(
                  //   fit: BoxFit.cover,
                  //   image: ,
                  // ),
                ),
                child: Stack(
                  children: [
                    Container(
                      
                         height: orientation == Orientation.portrait
                      ? mediaQuery.height / 4.5
                      : mediaQuery.width /
                          4.5,
                      decoration: BoxDecoration( 
                        
                                         borderRadius: BorderRadius.circular(12),
),clipBehavior: Clip.hardEdge,
                     child: Image(
                     
                        image: CachedNetworkImageProvider(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
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
                        // image: DecorationImage(
                        //   fit: BoxFit.cover,
                        //   image: ,
                        // ),
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
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 6),
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
                          style:  TextStyle(
                            color:isFromFav?AppColors.orange: Colors.blue,
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
  const DateSectionWidget({
    this.title,
    this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
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
