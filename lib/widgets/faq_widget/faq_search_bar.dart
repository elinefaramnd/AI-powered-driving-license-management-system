import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';

class FaqSearchBar extends StatelessWidget {
  final double w;
  final TextEditingController searchController;
  final Function(String) onChanged;

  const FaqSearchBar({
    super.key,
    required this.w,
    required this.searchController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.045),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        onChanged: onChanged,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          hintText: 'ابحث عن سؤال...',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: w * 0.037,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors.primary,
            size: 22,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
