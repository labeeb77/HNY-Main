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
import 'package:hny_main/view/common/bottom_nav.dart';
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
                        (globalUser?.strFullName == null ||
                                globalUser!.strFullName!.isEmpty)
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
                                        fontSize: 12,
                                        color: AppColors.textSecondary),
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
              Consumer<ProfileProvider>(
                builder: (context, value, child) {
                  // Count visible documents
                  int visibleDocs = 1; // License is always visible
                  if (globalUser?.strCitizenType == 'tourist') {
                    visibleDocs += 2; // Passport and Visa Card
                  } else if (globalUser?.strCitizenType == 'gcc') {
                    visibleDocs += 1; // GCC ID
                  } else if (globalUser?.strCitizenType == 'resident') {
                    visibleDocs += 1; // Emirates ID
                  }

                  return Container(
                    width: double.infinity,
                    child: Wrap(
                      spacing: visibleDocs == 1 ? 0 : 16,
                      runSpacing: 16,
                      alignment: visibleDocs == 1 
                          ? WrapAlignment.center 
                          : visibleDocs == 2 
                              ? WrapAlignment.center 
                              : WrapAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            DocumentElement(
                              argument: "profile",
                              routeName: AppRoutes.manageLicense,
                              docIcon: Icons.document_scanner_outlined,
                              docName: "License",
                              imageUrl: globalUser?.strLicenceUrl,
                              isEnabled:
                                  globalUser?.strLicenceUrl?.isNotEmpty ?? false,
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
                        if (globalUser?.strCitizenType == 'tourist')
                          Stack(
                            children: [
                              DocumentElement(
                                argument: "profile",
                                routeName: AppRoutes.managePassport,
                                docIcon: Icons.file_copy_outlined,
                                docName: "Passport",
                                imageUrl: globalUser?.strPassportUrl,
                                isEnabled:
                                    globalUser?.strPassportUrl?.isNotEmpty ?? false,
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
                        if (globalUser?.strCitizenType == 'gcc')
                          Stack(
                            children: [
                              DocumentElement(
                                argument: "profile",
                                routeName: AppRoutes.manageGccId,
                                docIcon: Icons.folder_copy_outlined,
                                docName: "GCC ID",
                                imageUrl: globalUser?.strGccIdUrl,
                                isEnabled:
                                    globalUser?.strGccIdUrl?.isNotEmpty ?? false,
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
                        if (globalUser?.strCitizenType == 'tourist')
                          Stack(
                            children: [
                              DocumentElement(
                                argument: "profile",
                                routeName: AppRoutes.manageVisaCard,
                                docIcon: Icons.folder_copy_outlined,
                                docName: "Visa Card",
                                imageUrl: globalUser?.strVisaUrl,
                                isEnabled:
                                    globalUser?.strVisaUrl?.isNotEmpty ?? false,
                              ),
                              if (globalUser?.strVisaUrl?.isEmpty ?? true)
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
                        if (globalUser?.strCitizenType == 'resident')
                          Stack(
                            children: [
                              DocumentElement(
                                argument: "profile",
                                routeName: AppRoutes.manageEmiratesId,
                                docIcon: Icons.folder_copy_outlined,
                                docName: "Emirates Id",
                                imageUrl: globalUser?.strEmiratesIdUrl,
                                isEnabled:
                                    globalUser?.strEmiratesIdUrl?.isNotEmpty ??
                                        false,
                              ),
                              if (globalUser?.strEmiratesIdUrl?.isEmpty ?? true)
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
                  );
                },
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
                child: Column(
                  children: [
                    GeneralElementContainer(
                      onTap: () {
                        BottomNavController bookingProvider =
                            Provider.of<BottomNavController>(context,
                                listen: false);
                        bookingProvider.changeScreenIndex(1);
                      },
                      title: "My Bookings",
                      leadingIcon: Icons.book_online_outlined,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Divider(
                        color: AppColors.lightDivider,
                        height: 28,
                      ),
                    ),
                    GeneralElementContainer(
                      onTap: () {
                        BottomNavController bookingProvider =
                            Provider.of<BottomNavController>(context,
                                listen: false);
                        bookingProvider.changeScreenIndex(2);
                      },
                      title: "My Favorites",
                      leadingIcon: Icons.favorite_border_outlined,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Divider(
                        color: AppColors.lightDivider,
                        height: 28,
                      ),
                    ),
                    GeneralElementContainer(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.myCartPage);
                      },
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
