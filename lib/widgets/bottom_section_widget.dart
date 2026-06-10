import 'package:flutter/material.dart';

class BottomSectionWidget extends StatelessWidget {
  const BottomSectionWidget({super.key});

  Widget _box(BuildContext context, String title) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.15,
      color: Colors.white,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: size.width * 0.04,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(child: _box(context, "التنبيهات")),
        SizedBox(width: size.width * 0.025),
        Expanded(child: _box(context, "رخصي")),
      ],
    );
  }
}