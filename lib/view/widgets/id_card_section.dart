import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class IDCardImageSection extends StatelessWidget {
  final double height;
  final String defaultImagePath;
  
  const IDCardImageSection({
    Key? key,
    this.height = 220,
    this.defaultImagePath = 'assets/images/placeholder_image.webp',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'ID Card',
            style: TextStyle(
              color: Color(0xFF006C3F),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          _IDCardImageWidget(
            height: height,
            defaultImagePath: defaultImagePath,
          ),
        ],
      ),
    );
  }
}

class _IDCardImageWidget extends StatelessWidget {
  final double height;
  final String defaultImagePath;

  const _IDCardImageWidget({
    Key? key,
    required this.height,
    required this.defaultImagePath,
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
            child: _buildIDCardImage(profileProvider),
          );
        },
      ),
    );
  }

  Widget _buildIDCardImage(ProfileProvider profileProvider) {
    // Case 1: Selected image exists (highest priority)
    if (profileProvider.selectedGCCIdCardImagePath != null) {
      return kIsWeb? Image.network(
        profileProvider.selectedGCCIdCardImagePath!.path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultImage(),
      ):Image.file(
        profileProvider.selectedGCCIdCardImagePath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultImage(),
      );
    }

    // Case 2: ID Card URL exists
    final idCardUrl = globalUser?.strGccIdUrl;
    if (idCardUrl != null && idCardUrl.isNotEmpty) {
      return Image.network(
        idCardUrl,
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
                Icons.credit_card,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 8),
              Text(
                'Add ID Card',
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
