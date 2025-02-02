import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_image_picker.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:hny_main/view/screens/main/bookings/widgets/file_upload_ui_widget.dart';
import 'package:hny_main/view/screens/main/profile/add_driving_license_screen.dart';
import 'package:hny_main/view/widgets/back_button.dart';
import 'package:provider/provider.dart';

class EditGccIdScreen extends StatelessWidget {
  const EditGccIdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddDrivingLicenseScreen(),
                  ));
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
          'Edit ${profileProvider.getIdTitleName()} ID',
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
                onTap: () async =>
                    Provider.of<ProfileProvider>(context, listen: false)
                        .setIdCardImagePath(
                            await AppImagePicker().pickImageFromGallery()),
                child: const FileUploadUIWidget()),
            const SizedBox(height: 24),
            // GCC ID Label
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: const Color(0xFFD9E5E3).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.withOpacity(0.5))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${profileProvider.getIdTitleName()} ID',
                    style: const TextStyle(
                      color: Color(0xFF006C3F),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // ID Card Container
                  Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Consumer<ProfileProvider>(
                      builder: (context, value, child) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: value.selectedIdCardImagePath == null
                              ? Image.asset(
                                  'assets/images/placeholder_image.webp', // Add your placeholder image
                                  fit: BoxFit.cover,
                                )
                              : Image(
                                  fit: BoxFit.cover,
                                  image:
                                      FileImage(value.selectedIdCardImagePath!
                                          // Add your placeholder image
                                          ))),
                    ),
                  ),
                ],
              ),
            )
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
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddDrivingLicenseScreen(),
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
              ),
            ),
            child: const Text(
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
  }
}
