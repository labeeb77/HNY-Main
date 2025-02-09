import 'package:flutter/material.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_image_picker.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:hny_main/view/screens/main/bookings/widgets/file_upload_ui_widget.dart';
import 'package:hny_main/view/screens/main/profile/add_driving_license_screen.dart';
import 'package:hny_main/view/widgets/back_button.dart';
import 'package:hny_main/view/widgets/id_card_section.dart';
import 'package:provider/provider.dart';

class EditIdScreen extends StatelessWidget {
  const EditIdScreen({super.key});

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
            const IDCardImageSection(
              height: 220,
              defaultImagePath:
                  'assets/images/custom_placeholder.webp', // Optional
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
