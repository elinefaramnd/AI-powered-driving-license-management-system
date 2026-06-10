import 'package:flutter/material.dart';

class DocumentIconBox extends StatelessWidget {
  final String code;
  final String name;

  const DocumentIconBox({
    super.key,
    required this.code,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    return Container(
        width: w * 0.123,
        height: w * 0.123,
      decoration: BoxDecoration(
        color: _background(code),
        borderRadius:
        BorderRadius.circular(w * 0.064),
        border: Border.all(
          color: Colors.white,
          width: w * 0.007,
        ),
        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(.05),
            blurRadius: w * 0.015,
          ),
        ],
      ),
      child: Icon(
        _icon(name),
        color: _color(code),
        size: w * 0.063,
      ),
    );
  }

  Color _background(String code) {
    switch (code) {
      case "national_id_copy":
        return const Color(0xffE8F0FE);

      case "personal_photo":
        return const Color(0xffFFF4E5);

      case "medical_report":
        return const Color(0xffE8F5EC);

      case "blood_donation_certificate":
        return const Color(0xffFDECEC);

      default:
        return const Color(0xffF4F4F4);
    }
  }

  Color _color(String code) {
    switch (code) {
      case "national_id_copy":
        return Colors.blue;

      case "personal_photo":
        return Colors.orange;

      case "medical_report":
        return Colors.green;

      case "blood_donation_certificate":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  IconData _icon(String name) {
    final text = name.toLowerCase();

    if (text.contains("national")) {
      return Icons.badge_outlined;
    }

    if (text.contains("personal")) {
      return Icons.person_outline;
    }

    if (text.contains("blood")) {
      return Icons.bloodtype_outlined;
    }

    if (text.contains("medical")) {
      return Icons.monitor_heart_outlined;
    }

    return Icons.description_outlined;
  }
}