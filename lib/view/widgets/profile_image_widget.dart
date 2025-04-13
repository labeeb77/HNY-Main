import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hny_main/core/global/profile.dart';
import 'package:hny_main/data/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileImageWidget extends StatelessWidget {
  final double size;
  final Function() onTap;
  final String defaultImagePath;

  const ProfileImageWidget({
    Key? key,
    this.size = 100,
    required this.onTap,
    this.defaultImagePath = 'assets/images/placeholder_image.webp',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        return InkWell(
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: _buildProfileImage(profileProvider),
          ),
        );
      },
    );
  }

  Widget _buildProfileImage(ProfileProvider profileProvider) {
    // Case 1: Selected image exists (highest priority)
    if (profileProvider.selectedProfileImage != null) {
      return kIsWeb? Image.network(
        profileProvider.selectedProfileImage!.path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultImage(),
      ):Image.file(
        profileProvider.selectedProfileImage!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultImage(),
      );
    }

    // Case 2: Profile URL exists
    final profileUrl = globalUser?.strProfileUrl;
    if (profileUrl != null && profileUrl.isNotEmpty) {
      return Image.network(
        profileUrl,
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
        child: Icon(
          Icons.person,
          size: size * 0.5,
          color: Colors.grey[400],
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
