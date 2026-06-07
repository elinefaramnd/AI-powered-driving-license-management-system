import 'package:flutter/material.dart';

class OrderActions extends StatelessWidget {
  const OrderActions({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Row(
      children: [
        // Expanded(
        //   child: SizedBox(
        //     height: h * 0.057,
        //     child: OutlinedButton.icon(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.share,
        //         color: AppColors.primaryColor,
        //       ),
        //       label: const Text(
        //         "مشاركة التفاصيل",
        //         style: TextStyle(
        //           color: AppColors.primaryColor,
        //         ),
        //       ),
        //       style: OutlinedButton.styleFrom(
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(16),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        //
        // SizedBox(width:  w * 0.03),
        //
        // Expanded(
        //   child: SizedBox(
        //     height: h * 0.057,
        //     child: ElevatedButton.icon(
        //       onPressed: () {},
        //       icon: const Icon(Icons.download),
        //       label: const Text("تحميل المرفقات"),
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor: AppColors.primaryColor,
        //         foregroundColor: Colors.white,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(w * 0.04),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}