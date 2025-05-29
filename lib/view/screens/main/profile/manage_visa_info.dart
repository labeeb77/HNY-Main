import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/core/utils/app_alerts.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_image_picker.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:hny_main/view/screens/main/Bookings/widgets/file_upload_ui_widget.dart';
import 'package:hny_main/view/screens/main/profile/manage_license.dart';
import 'package:hny_main/view/screens/main/profile/manage_passport.dart';
import 'package:hny_main/view/widgets/back_button.dart';
import 'package:hny_main/view/widgets/id_card_section.dart';
import 'package:provider/provider.dart';

class ManageVisaInfo extends StatefulWidget {
  const ManageVisaInfo({super.key, required this.from});
  final from;
  @override
  State<ManageVisaInfo> createState() => _ManageVisaInfoState();
}

class _ManageVisaInfoState extends State<ManageVisaInfo> {
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
                    if (profileProvider.selectedCitizenshipType == 'Tourist') {
                      Navigator.pushNamed(context, AppRoutes.manageLicense,
                          arguments: widget.from);
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
            title: Text(
              'Add Visa Card',
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
                      profileProvider.setVisaCardImagePath(selectedImage);
                    }
                  },
                  child: const FileUploadUIWidget(),
                ),
                const SizedBox(height: 24),
                // Visa ID Image Display
                if (profileProvider.selectedVisaCardImagePath != null)
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: kIsWeb
                            ? NetworkImage(
                                profileProvider.selectedVisaCardImagePath!.path)
                            : FileImage(
                                profileProvider.selectedVisaCardImagePath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else if (globalUser?.strVisaUrl != null &&
                    globalUser!.strVisaUrl!.isNotEmpty)
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(globalUser!.strVisaUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                 DocumentImageSection(
                    title: "Visa ID",
                    height: 220,
                    defaultImagePath: 'assets/images/placeholder_image.webp',
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
                        if (profileProvider.selectedVisaCardImagePath != null) {
                          final success =
                              await profileProvider.updateDocumentUrl(
                            context,
                            documentFile:
                                profileProvider.selectedVisaCardImagePath,
                            documentType: 'Visa Card',
                          );
                          (context);
                          if (success) {
                            AppAlerts.showCustomSnackBar(
                                "Visa Card updated successfully",
                                isSuccess: true);

                            if (widget.from == "register") {
                              if (profileProvider.selectedCitizenshipType ==
                                  'tourist') {
                                Navigator.pushNamed(
                                    context, AppRoutes.manageLicense,
                                    arguments: widget.from);
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
                                  context, AppRoutes.manageLicense,
                                  arguments: widget.from);
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
