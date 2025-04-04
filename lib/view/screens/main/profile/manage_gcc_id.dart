import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_image_picker.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:hny_main/view/screens/main/Bookings/widgets/file_upload_ui_widget.dart';
import 'package:hny_main/view/screens/main/profile/manage_license.dart';
import 'package:hny_main/view/widgets/back_button.dart';
import 'package:hny_main/view/widgets/id_card_section.dart';
import 'package:provider/provider.dart';

class ManageGCCId extends StatefulWidget {
  const ManageGCCId({super.key});

  @override
  State<ManageGCCId> createState() => _ManageGCCIdState();
}

class _ManageGCCIdState extends State<ManageGCCId> {
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
                      builder: (context) => const ManageDrivingLicense(),
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
            title: Text(
              'Add GCC ID',
              style: const TextStyle(
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
                      profileProvider.setGCCIdCardImagePath(selectedImage);
                    }
                  },
                  child: const FileUploadUIWidget(),
                ),
                const SizedBox(height: 24),
                // GCC ID Image Display
                if (profileProvider.selectedGCCIdCardImagePath != null)
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image:
                            FileImage(profileProvider.selectedGCCIdCardImagePath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else if (globalUser?.strGccIdUrl != null &&
                    globalUser!.strGccIdUrl!.isNotEmpty)
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(globalUser!.strGccIdUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  const IDCardImageSection(
                    height: 220,
                    defaultImagePath: 'assets/images/custom_placeholder.webp',
                  )
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
                        if (profileProvider.selectedGCCIdCardImagePath !=
                            null) {
                          final success =
                              await profileProvider.updateDocumentUrl(
                            context,
                            documentFile:
                                profileProvider.selectedGCCIdCardImagePath,
                            documentType: 'GCC ID',
                          );
                          (context);
                          if (success) {
                            AppAlerts.showCustomSnackBar(
                                "GCC ID updated successfully",
                                isSuccess: true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ManageDrivingLicense(),
                              ),
                            );
                          }
                        } else {
                          // If no image is selected, just navigate to next screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ManageDrivingLicense(),
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
                    ? const CircularProgressIndicator(color: Colors.white)
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
