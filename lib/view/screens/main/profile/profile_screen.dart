import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/auth_provider.dart';
import 'package:hny_main/data/providers/bottom_nav_controller.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:hny_main/view/screens/main/profile/widgets_elements.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';
import 'package:hny_main/view/widgets/common_app_bar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProfileProvider>(context, listen: false)
        .getUserProfileDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("global user: ${globalUser?.strGccIdUrl}");
    log("global user: ${globalUser?.strLicenceUrl}");
    log("global user: ${globalUser?.strPassportUrl}");

    
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F6),
      appBar: const CommonAppBar(
        title: "My Profile",
        showLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.manageProfile,
                      arguments: 'Edit');
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 220, 218, 218)
                                .withOpacity(0.1),
                            blurRadius: 1,
                            spreadRadius: 5,
                            offset: const Offset(1, 1))
                      ]),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Consumer<ProfileProvider>(
                    builder: (context, value, child) => Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: (globalUser
                                      ?.strProfileUrl?.isNotEmpty ??
                                  false)
                              ? CachedNetworkImageProvider(
                                  globalUser!.strProfileUrl!)
                              : const AssetImage(
                                      'assets/images/placeholder_image.webp')
                                  as ImageProvider,
                        ),
                        const Gap(16),
                        (globalUser?.strFullName == null || globalUser!.strFullName!.isEmpty)
                            ? const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    "Complete your profile",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Gap(4),
                                  AppText(
                                    "Add your information",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(globalUser?.strFullName ?? "Unknown"),
                                  const Gap(4),
                                  AppText(
                                    globalUser?.strEmail ?? "No email",
                                    style: const TextStyle(
                                        fontSize: 12, color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppColors.iconGrey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      DocumentElement(
                        docIcon: Icons.document_scanner_outlined,
                        docName: "License",
                        imageUrl: globalUser?.strLicenceUrl,
                        isEnabled: globalUser?.strLicenceUrl?.isNotEmpty ?? false,
                      ),
                      if (globalUser?.strLicenceUrl?.isEmpty ?? true)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Stack(
                    children: [
                      DocumentElement(
                        docIcon: Icons.file_copy_outlined,
                        docName: "Passport",
                        imageUrl: globalUser?.strPassportUrl,
                        isEnabled: globalUser?.strPassportUrl?.isNotEmpty ?? false,
                      ),
                      if (globalUser?.strPassportUrl?.isEmpty ?? true)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Stack(
                    children: [
                      DocumentElement(
                        docIcon: Icons.folder_copy_outlined,
                        docName: "GCC ID",
                        imageUrl: globalUser?.strGccIdUrl,
                        isEnabled: globalUser?.strGccIdUrl?.isNotEmpty ?? false,
                      ),
                      if (globalUser?.strGccIdUrl?.isEmpty ?? true)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              const Gap(25),
              const AppText(
                "General",
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              const Gap(15),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 220, 218, 218)
                              .withOpacity(0.1),
                          blurRadius: 1,
                          spreadRadius: 5,
                          offset: const Offset(1, 1))
                    ]),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                child: const Column(
                  children: [
                    GeneralElementContainer(
                      title: "My Bookings",
                      leadingIcon: Icons.book_online_outlined,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Divider(
                        color: AppColors.lightDivider,
                        height: 28,
                      ),
                    ),
                    GeneralElementContainer(
                      title: "My Favorites",
                      leadingIcon: Icons.favorite_border_outlined,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Divider(
                        color: AppColors.lightDivider,
                        height: 28,
                      ),
                    ),
                    GeneralElementContainer(
                      title: "My Cart",
                      leadingIcon: Icons.shopping_bag_outlined,
                    ),
                  ],
                ),
              ),
              const Gap(25),
              const AppText(
                "Help",
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              const Gap(15),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 220, 218, 218)
                              .withOpacity(0.1),
                          blurRadius: 1,
                          spreadRadius: 5,
                          offset: const Offset(1, 1))
                    ]),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                child: const Column(
                  children: [
                    GeneralElementContainer(
                      title: "About us",
                      leadingIcon: Icons.info_outline,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Divider(
                        color: AppColors.lightDivider,
                        height: 28,
                      ),
                    ),
                    GeneralElementContainer(
                      title: "FAQ",
                      leadingIcon: Icons.skateboarding_sharp,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Divider(
                        color: AppColors.lightDivider,
                        height: 28,
                      ),
                    ),
                    GeneralElementContainer(
                      title: "Delete Account",
                      leadingIcon: Icons.delete_outline_outlined,
                      isDelete: true,
                    ),
                  ],
                ),
              ),
              const Gap(25),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .logout()
                        .then((_) async {
                      Provider.of<BottomNavController>(context, listen: false)
                          .changeScreenIndex(0, false);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.loginPage, (route) => true);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orange),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
              const Gap(25),
            ],
          ),
        ),
      ),
    );
  }
}
