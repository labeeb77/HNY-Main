import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_image_picker.dart';
import 'package:hny_main/data/providers/auth_provider.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:hny_main/view/screens/main/profile/add_id_card_screen.dart';
import 'package:hny_main/view/widgets/profile_image_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ManageProfileScreen extends StatefulWidget {
  final screenName;
  const ManageProfileScreen({required this.screenName, super.key});

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  @override
  void initState() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      profileProvider.initialMethod();
    });
    super.initState();
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  Provider.of<ProfileProvider>(context, listen: false)
                      .setProfileImage(
                          await AppImagePicker().pickImageFromGallery());
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Capture from Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  Provider.of<ProfileProvider>(context, listen: false)
                      .setProfileImage(
                          await AppImagePicker().captureImageFromCamera());
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    log(profileProvider.firstNameController.text);
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title: Text(
            "${widget.screenName} Profile",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.idCardPage);
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
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      ProfileImageWidget(
                        size: 100,
                        onTap: () => _showImageSourceActionSheet(context),
                        defaultImagePath:
                            'assets/images/custom_placeholder.png', // Optional
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.deepOrange,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildInputField(
                    'First Name', profileProvider.firstNameController),
                _buildInputField(
                    'Last Name', profileProvider.lastNameController,
                    keyboardType: TextInputType.text),
                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    'Gender Type',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                Consumer<ProfileProvider>(
                  builder: (context, value, child) => Row(
                    children: [
                      _buildRadioButton('Male', value),
                      const SizedBox(width: 32),
                      _buildRadioButton('Female', value),
                    ],
                  ),
                ),
                _buildInputField(
                  ontap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      profileProvider.dobController.text =
                          formatDateToISO(date);
                    }
                  },
                  keyboardType: TextInputType.none,
                  'Date of Birth',
                  profileProvider.dobController,
                  suffix: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        profileProvider.dobController.text =
                            formatDateToISO(date);
                      }
                    },
                  ),
                ),
                _buildInputField(
                    'Mobile Number', profileProvider.mobileController,
                    keyboardType: TextInputType.phone, readOnly: true),
                _buildInputField('Email ID', profileProvider.emailController,
                    keyboardType: TextInputType.emailAddress),
                _buildDropdownField(
                    'Nationality',
                    profileProvider.selectedNationality,
                    ['India', 'UAE', 'American'],
                    profileProvider),
                _buildDropdownField(
                    'Citizenship Type',
                    profileProvider.selectedCitizenship,
                    ['Emirati', 'GCC', 'International'],
                    profileProvider),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: widget.screenName == 'Add'
              ? SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.idCardPage);
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
                )
              : Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.idCardPage);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.greenShadeBackground,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(0))),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.idCardPage);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(0))),
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
        ));
  }

  String formatDateToISO(DateTime date) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(date.toUtc());
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    Widget? suffix,
    VoidCallback? ontap,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF82868B),
                fontSize: 14,
              ),
            ),
          ),
          TextFormField(
            onTap: ontap,
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly || (ontap != null), // Modified this line
            enabled: !readOnly, // Added this line
            decoration: InputDecoration(
              fillColor: readOnly
                  ? Colors.grey[200]
                  : AppColors.white, // Added this line
              filled: true,
              suffixIcon: suffix,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioButton(String value, ProfileProvider provider) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.zero,
          child: Radio<String>(
            value: value,
            groupValue: provider.selectedGender,
            onChanged: (String? newValue) {
              provider.setGender(newValue!);
            },
          ),
        ),
        Text(value),
      ],
    );
  }

  Widget _buildDropdownField(String label, String? value, List<String> items,
      ProfileProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF82868B),
                fontSize: 14,
              ),
            ),
          ),
          DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              fillColor: AppColors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (label == 'Nationality') {
                provider.setNationality(newValue!);
              } else {
                provider.setCitizenship(newValue!);
              }
            },
          ),
        ],
      ),
    );
  }
}
