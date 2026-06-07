import 'package:flutter/material.dart';

class EmptyDocumentsWidget extends StatelessWidget {
  const EmptyDocumentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: h * 0.037,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.04),
        border: Border.all(
          color: const Color(0xffE9ECEF),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.folder_off_outlined,
            size: w * 0.125,
            color: Colors.grey.shade400,
          ),
           SizedBox(height:  h * 0.015),
           Text(
            "لا يوجد مستندات مرفوعة",
            style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height:  h * 0.007),
          Text(
            "قم برفع المستندات المطلوبة لإكمال الطلب",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize:  w * 0.033,
            ),
          ),
        ],
      ),
    );
  }
}