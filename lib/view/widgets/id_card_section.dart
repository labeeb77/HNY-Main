import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DocumentImageSection extends StatelessWidget {
  final double height;
  final String? defaultImagePath;
  final String title;
  final Color backgroundColor;
  final Color titleColor;
  final File? selectedImage;
  final String? imageUrl;
  final VoidCallback? onTap;
  final String placeholderText;
  final IconData placeholderIcon;
  
  const DocumentImageSection({
    Key? key,
    this.height = 220,
    this.defaultImagePath,
    this.title = 'Document',
    this.backgroundColor = const Color(0xFFD9E5E3),
    this.titleColor = const Color(0xFF006C3F),
    this.selectedImage,
    this.imageUrl,
    this.onTap,
    this.placeholderText = 'Add Document',
    this.placeholderIcon = Icons.credit_card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          _DocumentImageWidget(
            height: height,
            defaultImagePath: defaultImagePath,
            selectedImage: selectedImage,
            imageUrl: imageUrl,
            onTap: onTap,
            placeholderText: placeholderText,
            placeholderIcon: placeholderIcon,
          ),
        ],
      ),
    );
  }
}

class _DocumentImageWidget extends StatelessWidget {
  final double height;
  final String? defaultImagePath;
  final File? selectedImage;
  final String? imageUrl;
  final VoidCallback? onTap;
  final String placeholderText;
  final IconData placeholderIcon;

  const _DocumentImageWidget({
    Key? key,
    required this.height,
    this.defaultImagePath,
    this.selectedImage,
    this.imageUrl,
    this.onTap,
    this.placeholderText = 'Add Document',
    this.placeholderIcon = Icons.credit_card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    // Case 1: Selected image exists (highest priority)
    if (selectedImage != null) {
      return _buildImageFromFile(selectedImage!);
    }

    // Case 2: Image URL exists
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return _buildImageFromUrl(imageUrl!);
    }

    // Case 3: Default fallback
    return _buildDefaultImage();
  }

  Widget _buildImageFromFile(File file) {
    if (kIsWeb) {
      return Image.network(
        file.path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildDefaultImage(),
      );
    }
    return Image.file(
      file,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildDefaultImage(),
    );
  }

  Widget _buildImageFromUrl(String url) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildDefaultImage(),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildLoadingIndicator(loadingProgress);
      },
    );
  }

  Widget _buildDefaultImage() {
    if (defaultImagePath != null) {
      return Image.asset(
        defaultImagePath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              placeholderIcon,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 8),
            Text(
              placeholderText,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(ImageChunkEvent? loadingProgress) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value: loadingProgress?.expectedTotalBytes != null
                  ? loadingProgress!.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
            const SizedBox(height: 8),
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
