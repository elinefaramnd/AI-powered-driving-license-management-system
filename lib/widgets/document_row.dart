// import 'package:flutter/material.dart';
// import '../app_theme/app_colors.dart';
//
// class DocumentRow extends StatelessWidget {
//   final dynamic doc;
//   final bool uploaded;
//
//   const DocumentRow({required this.doc, required this.uploaded});
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       textDirection: TextDirection.rtl,
//       children: [
//         Container(
//           width: 45,
//           height: 45,
//           decoration: BoxDecoration(
//             color: uploaded ? const Color(0xffEEF3F8) : const Color(0xffF6F2EA),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Icon(
//             uploaded ? Icons.check_circle_rounded : Icons.upload_file_rounded,
//             size: 24,
//             color: AppColors.primaryColor,
//           ),
//         ),
//         const SizedBox(width: 14),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 doc["name"],
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 18,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 uploaded ? "تم الرفع بنجاح" : "مطلوب رفع حالياً",
//                 style: TextStyle(
//                   color: uploaded
//                       ? AppColors.primaryColor
//                       : const Color(0xff7B8794),
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
