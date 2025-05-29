import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_image_picker.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:hny_main/view/common/bottom_nav.dart';
import 'package:hny_main/view/screens/main/Bookings/widgets/file_upload_ui_widget.dart';
import 'package:hny_main/view/screens/main/profile/manage_license.dart';
import 'package:hny_main/view/widgets/back_button.dart';
import 'package:hny_main/view/widgets/id_card_section.dart';
import 'package:provider/provider.dart';

class ManagePassport extends StatefulWidget {
  const ManagePassport({super.key, required this.from});
  final from;
  @override
  State<ManagePassport> createState() => _ManagePassportState();
}

class _ManagePassportState extends State<ManagePassport> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              Visibility(
                visible: widget.from == "register",
                child: TextButton(
                  onPressed: () {
                      if (profileProvider.selectedCitizenshipType ==
                          'Tourist') {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.manageVisaCard,
                          arguments: widget.from,
                        );
                      }
                    
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const CommonBackButton(
              showBorder: true,
            ),
            title: const Text(
              'Add Passport ID',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Upload Container
                InkWell(
                  onTap: () async {
                    File? selectedImage =
                        await AppImagePicker().pickImageFromGallery();
                    if (selectedImage != null) {
                      profileProvider.setPassportImagePath(selectedImage);
                    }
                  },
                  child: const FileUploadUIWidget(),
                ),
                const SizedBox(height: 24),
                // Passport Container
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                    const SizedBox(height: 12),
                    // Passport Image Display
                    if (profileProvider.selectedPassportImagePath != null)
                      Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: kIsWeb
                                ? NetworkImage(profileProvider
                                    .selectedPassportImagePath!.path)
                                : FileImage(profileProvider
                                    .selectedPassportImagePath!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    else if (globalUser?.strPassportUrl != null &&
                        globalUser!.strPassportUrl!.isNotEmpty)
                      Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(globalUser!.strPassportUrl!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    else
                      // You might need to create a PassportImageWidget similar to DrivingLicenseImageWidget
                      DocumentImageSection(
                  title: "Passport ID",
                  height: 220,
                  defaultImagePath: 'assets/images/placeholder_image.webp',
                )
                  ],
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: profileProvider.isLoading
                    ? null
                    : () async {
                        if (profileProvider.selectedPassportImagePath != null) {
                          final success =
                              await profileProvider.updateDocumentUrl(
                            context,
                            documentFile:
                                profileProvider.selectedPassportImagePath,
                            documentType: 'Passport',
                          );
                          (context);
                          if (success) {
                            if (widget.from == "register") {
                              AppAlerts.showCustomSnackBar(
                                  "Passport updated successfully",
                                  isSuccess: true);
                              if (profileProvider.selectedCitizenshipType ==
                                  'tourist') {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.manageVisaCard,
                                  arguments: widget.from,
                                );
                              }
                            } else {
                              Navigator.pop(context);
                            }
                          }
                        } else {
                          // If no image is selected, just navigate to next screen
                          if (widget.from == "register") {
                            if (profileProvider.selectedCitizenshipType ==
                                'tourist') {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.manageVisaCard,
                                arguments: widget.from,
                              );
                            }
                          } else {
                            Navigator.pop(context);
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                ),
                child: profileProvider.isLoading
                    ? const CircularProgressIndicator(
                        color: AppColors.white,
                      )
                    : const Text(
                        'Save',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
