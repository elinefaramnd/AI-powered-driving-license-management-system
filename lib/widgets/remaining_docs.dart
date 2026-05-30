import 'package:flutter/material.dart';

import '../app_theme/app_colors.dart';

class RemainingDocs extends StatelessWidget {
  final dynamic controller;

  const RemainingDocs({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xffF6F2EA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Text(
          "متبقي ${controller.remaining} من الوثائق",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}