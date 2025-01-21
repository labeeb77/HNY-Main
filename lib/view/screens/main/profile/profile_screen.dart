import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/data/providers/auth_provider.dart';
import 'package:hny_main/view/screens/main/auth/sign_in_screen.dart';
import 'package:hny_main/view/screens/main/profile/widgets_elements.dart';
import 'package:hny_main/view/widgets/app_text_widget.dart';
import 'package:hny_main/view/widgets/common_app_bar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: const Row(
                  children: [
                    CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/placeholder_image.webp')),
                    Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText("Santosh Pandit"),
                        Gap(4),
                        AppText(
                          "santosh@gmail.com",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.iconGrey,
                    )
                  ],
                ),
              ),
              const Gap(25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DocumentElement(
                    docIcon: Icons.document_scanner_outlined,
                    docName: "License",
                  ),
                  DocumentElement(
                    docIcon: Icons.file_copy_outlined,
                    docName: "Passport",
                  ),
                  DocumentElement(
                    docIcon: Icons.folder_copy_outlined,
                    docName: "GCC ID",
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
                        .then((_) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()),
                        (route) => false, // Remove all previous routes
                      );
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
