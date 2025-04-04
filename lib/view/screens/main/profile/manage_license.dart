import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_image_picker.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:hny_main/view/common/bottom_nav.dart';
import 'package:hny_main/view/screens/main/Bookings/widgets/file_upload_ui_widget.dart';
import 'package:hny_main/view/screens/main/home/home_screen.dart';
import 'package:hny_main/view/screens/main/profile/manage_passport.dart';
import 'package:hny_main/view/widgets/back_button.dart';
import 'package:hny_main/view/widgets/liecense_image_widget.dart';
import 'package:provider/provider.dart';

class ManageDrivingLicense extends StatefulWidget {
  const ManageDrivingLicense({super.key});

  @override
  State<ManageDrivingLicense> createState() => _ManageDrivingLicenseState();
}

class _ManageDrivingLicenseState extends State<ManageDrivingLicense> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNav(),
                    ),
                  );
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
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
              'Add Driving License ID',
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
                    File? selectedImage = await AppImagePicker().pickImageFromGallery();
                    if (selectedImage != null) {
                      profileProvider.setDrivingLicenseImagePath(selectedImage);
                    }
                  },
                  child: const FileUploadUIWidget(),
                ),
                const SizedBox(height: 24),
                // Driving License Container
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9E5E3).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Driving License ID',
                        style: TextStyle(
                          color: Color(0xFF006C3F),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // License Image Display
                      if (profileProvider.selectedDrivingLicenseImagePath != null)
                        Container(
                          height: 220,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: FileImage(profileProvider.selectedDrivingLicenseImagePath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else if (globalUser?.strLicenceUrl != null && globalUser!.strLicenceUrl!.isNotEmpty)
                        Container(
                          height: 220,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(globalUser!.strLicenceUrl!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else
                        const DrivingLicenseImageWidget(
                          height: 220,
                          defaultImagePath: 'assets/images/custom_placeholder.webp',
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
               

                       onPressed: profileProvider.isLoading
                    ? null
                    : () async {
                        if (profileProvider.selectedDrivingLicenseImagePath !=
                            null) {
                          final success =
                              await profileProvider.updateDocumentUrl(
                            context,
                            documentFile:
                                profileProvider.selectedGCCIdCardImagePath,
                            documentType: 'License',
                          );
                          (context);
                          if (success) {
                              AppAlerts.showCustomSnackBar("Driving License updated successfully", isSuccess: true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ManagePassport(),
                              ),
                            );
                          }
                        } else {
                          // If no image is selected, just navigate to next screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ManagePassport(),
                            ),
                          );
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