import 'package:flutter/material.dart';

class InfoCardWidget extends StatelessWidget {
  final String title;
  final String value;

  const InfoCardWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Flexible(
            child: Text(
              value,

              textAlign: TextAlign.end,

              style: const TextStyle(
                fontWeight: FontWeight.w400,

                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            title,

            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
