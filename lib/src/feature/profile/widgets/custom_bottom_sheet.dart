import 'package:flutter/material.dart';
import 'package:quicklens/src/core/widgets/app/themes/text_styles.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final List<Widget> children;

  const CustomBottomSheet({
    super.key,
    required this.title,
    this.onBack,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Title + Back
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: onBack ?? () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 4),
                  Text(title, style: AppTextStyles.textTheme.titleLarge),
                ],
              ),

              const SizedBox(height: 12),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
