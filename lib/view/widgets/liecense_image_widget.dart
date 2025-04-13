import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class DrivingLicenseImageWidget extends StatelessWidget {
  final double height;
  final String defaultImagePath;
  
  const DrivingLicenseImageWidget({
    Key? key,
    this.height = 220,
    this.defaultImagePath = 'assets/images/placeholder_image.webp',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _buildLicenseImage(profileProvider),
          );
        },
      ),
    );
  }

  Widget _buildLicenseImage(ProfileProvider profileProvider) {
    // Case 1: Selected image exists (highest priority)
    if (profileProvider.selectedDrivingLicenseImagePath != null) {
      return kIsWeb? Image.network(
        profileProvider.selectedDrivingLicenseImagePath!.path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultImage(),
      ):Image.file(
        profileProvider.selectedDrivingLicenseImagePath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultImage(),
      );
    }

    // Case 2: License URL exists
    final licenseUrl = globalUser?.strLicenceUrl;
    if (licenseUrl != null && licenseUrl.isNotEmpty) {
      return Image.network(
        licenseUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultImage(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingIndicator();
        },
      );
    }

    // Case 3: Default fallback
    return _buildDefaultImage();
  }

  Widget _buildDefaultImage() {
    return Image.asset(
      defaultImagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.grey[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.drive_eta_rounded,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 8),
              Text(
                'Add Driving License',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
