import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hny_main/core/routes/app_routes.dart';
import 'package:hny_main/core/utils/app_colors.dart';
import 'package:hny_main/core/utils/app_image_picker.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:hny_main/view/widgets/profile_image_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ManageProfileScreen extends StatefulWidget {
  final String screenName;
  const ManageProfileScreen({required this.screenName, super.key});

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  final List<String> _countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Eswatini',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Korea, North',
    'Korea, South',
    'Kosovo',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'North Macedonia',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Timor-Leste',
    'Togo',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican City',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe'
  ];
  bool _isLoading = false;

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

  Future<void> _handleSave(BuildContext context, from) async {
    if (!_validateForm()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      final result = await profileProvider.addProfileData(context);

      if (result == true) {
        // Only navigate on success
        if (from == "Add") {
          Navigator.of(context).pushNamed(AppRoutes.manageGccId);
        } else {
          Navigator.pop(context);
        }
      } else {
        // Show an error message if not successful
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to save profile data. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool _validateForm() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    // Basic validation
    if (profileProvider.firstNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('First name is required')),
      );
      return false;
    }

    if (profileProvider.lastNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Last name is required')),
      );
      return false;
    }

    if (profileProvider.selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your gender')),
      );
      return false;
    }

    if (profileProvider.dobController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Date of birth is required')),
      );
      return false;
    }

    if (profileProvider.selectedNationality == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your nationality')),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    log(profileProvider.firstNameController.text);
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          actions: [
            Visibility(
              visible: widget.screenName == "Add",
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.manageGccId,
                      arguments:
                          widget.screenName == "Add" ? "register" : "profile");
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
          backgroundColor: AppColors.background,
          elevation: 0,
          title: Text(
            "${widget.screenName} Profile",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                          _buildRadioButton(
                              'Male', value, widget.screenName == "Edit"),
                          const SizedBox(width: 32),
                          _buildRadioButton(
                              'Female', value, widget.screenName == "Edit"),
                        ],
                      ),
                    ),
                    _buildInputField(
                      'Date of Birth',
                      profileProvider.dobController,
                      ontap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          // Store the ISO format internally if needed
                          final isoFormat = formatDateToISO(date);
                          // Display the user-friendly format
                          profileProvider.dobController.text =
                              formatDateForDisplay(date);
                        }
                      },
                      keyboardType: TextInputType.none,
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
                            // Store the ISO format internally if needed
                            final isoFormat = formatDateToISO(date);
                            // Display the user-friendly format
                            profileProvider.dobController.text =
                                formatDateForDisplay(date);
                          }
                        },
                      ),
                    ),
                    _buildInputField(
                        'Mobile Number', profileProvider.mobileController,
                        keyboardType: TextInputType.phone, readOnly: true),
                    _buildInputField(
                        'Email ID', profileProvider.emailController,
                        keyboardType: TextInputType.emailAddress),
                    _buildCountryDropdown(
                        'Nationality',
                        profileProvider.selectedNationality,
                        _countries,
                        profileProvider),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Loading overlay
            if (_isLoading || profileProvider.isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: widget.screenName == 'Add'
              ? SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () => _handleSave(context, widget.screenName),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                      ),
                    ),
                    child: Text(
                      _isLoading ? 'Saving...' : 'Save',
                      style: const TextStyle(
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
                        onPressed: _isLoading
                            ? null
                            : () {
                                Navigator.of(context).pop();
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
                        onPressed: _isLoading
                            ? null
                            : () => _handleSave(context, widget.screenName),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(0))),
                        child: Text(
                          _isLoading ? 'Updating...' : 'Update',
                          style: const TextStyle(
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

  String formatDateForDisplay(DateTime date) {
    return DateFormat("dd/MM/yyyy").format(date);
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
            readOnly: readOnly || (ontap != null),
            enabled: !readOnly,
            decoration: InputDecoration(
              fillColor: readOnly ? Colors.grey[200] : AppColors.white,
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

  Widget _buildRadioButton(String value, ProfileProvider provider, isEdit) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.zero,
          child: Radio<String>(
            value: value,
            groupValue: provider.selectedGender,
            onChanged: (String? newValue) {
              log(provider.selectedGender.toString());
              log(isEdit.toString());
              if (isEdit) {
                if (provider.selectedGender == null) {
                  provider.setGender(newValue!);
                }
              } else {
                provider.setGender(newValue!);
              }
            },
          ),
        ),
        Text(value),
      ],
    );
  }

  Widget _buildCountryDropdown(String label, String? value, List<String> items,
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
            value: value != null && items.contains(value) ? value : null,
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
              hintText: 'Select a country',
            ),
            isExpanded: true,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                provider.setNationality(newValue);
              }
            },
          ),
        ],
      ),
    );
  }
}
