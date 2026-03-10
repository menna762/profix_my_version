import 'dart:io';
import 'package:flutter/material.dart';

class IDUploadPicker extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onTap;
  final VoidCallback? onDelete; // اختياري لو عاوزه تمسحي الصورة بعد اختيارها

  const IDUploadPicker({
    super.key,
    required this.imageFile,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: imageFile == null ? Colors.grey.shade300 : const Color(0xFF4A90E2),
            style: BorderStyle.solid,
          ),
        ),
        child: imageFile == null
            ? _buildPlaceholder()
            : _buildImagePreview(),
      ),
    );
  }

  // الجزء اللي بيظهر لما ميكونش فيه صورة
  Widget _buildPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.upload_outlined, color: Colors.black54, size: 30),
        SizedBox(height: 8),
        Text(
          "Tap to upload your National ID",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Text(
          "JPG, PNG or PDF (Max 5MB)",
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }

  // الجزء اللي بيظهر لما المستخدم يختار صورة فعلاً
  Widget _buildImagePreview() {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(imageFile!, fit: BoxFit.cover),
        ),
        // زرار صغير لمسح الصورة لو المستخدم اختار غلط
        if (onDelete != null)
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onDelete,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.red.withValues(alpha: 0.8),
                child: const Icon(Icons.close, size: 16, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}