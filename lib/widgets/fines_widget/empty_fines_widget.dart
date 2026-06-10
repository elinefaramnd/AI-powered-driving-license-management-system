import 'package:flutter/material.dart';

class EmptyFinesWidget extends StatelessWidget {
  const EmptyFinesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * 0.025,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.verified,
              size: MediaQuery.of(context).size.width * 0.13,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.025),
            const Text("لا توجد غرامات مسجلة"),
          ],
        ),
      ),
    );
  }
}
