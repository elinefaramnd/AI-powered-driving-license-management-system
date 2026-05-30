import 'package:flutter/material.dart';
class BottomSectionWidget extends StatelessWidget {
  const BottomSectionWidget({super.key});

  Widget _box(String title) {
    return Container(
      height: 120,
      color: Colors.white,
      child: Center(child: Text(title)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _box("التنبيهات")),
        const SizedBox(width: 10),
        Expanded(child: _box("رخصي")),
      ],
    );
  }
}