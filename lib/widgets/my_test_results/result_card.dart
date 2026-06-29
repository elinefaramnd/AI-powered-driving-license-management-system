import 'package:flutter/material.dart';
import 'package:project_2/widgets/my_test_results/result_header.dart';
import 'package:project_2/widgets/my_test_results/result_info_block.dart';
import 'package:project_2/widgets/my_test_results/result_meta_section.dart';
import '../../app_theme/app_colors.dart';
import '../../modules/my_test_results/test_result_model.dart';
import '../../modules/my_test_results/test_results_controller.dart';

class ResultCard extends StatelessWidget {
  final Size size;
  final TestResultModel item;
  final TestResultsController controller;

  const ResultCard({
    super.key,
    required this.size,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final padding = size.width * 0.035;
    final smallSpace = size.height * 0.012;
    final mediumSpace = size.height * 0.02;

    final titleFont = size.width * 0.04;
    final subtitleFont = size.width * 0.032;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.035),
        border: Border.all(
          color: Colors.grey.withOpacity(0.19),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ResultHeader(
            size: size,
            result: item.result,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: size.width * 0.057,
                backgroundColor: const Color(0xffF2F4F7),
                child: Icon(
                  Icons.visibility,
                  size: size.width * 0.07,
                  color: Colors.black,
                ),
              ),

              SizedBox(width: size.width * 0.025),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     item.testName,
                      style: TextStyle(
                        fontSize: titleFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: smallSpace / 2),
                Text(controller.getTestDescription(item.testCode),
                      style: TextStyle(
                        fontSize: subtitleFont,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.045,
                  vertical: size.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(size.width * 0.06),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                      size: size.width * 0.04,
                    ),
                    SizedBox(width: size.width * 0.015),
                Text(controller.getResultText(item.result),
                      style: TextStyle(
                        fontSize: size.width * 0.038,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: mediumSpace),
          ResultMetaSection(
            size: size,
            item: item,
            controller: controller,
          ),

          SizedBox(height: mediumSpace),
          ResultInfoBlock(
            size: size,
            title: "الملاحظات",
            icon: Icons.notes,
            value: controller.getNotes(item.notes),
          ),

          SizedBox(height: smallSpace),
          ResultInfoBlock(
            size: size,
            title: "تم التسجيل بواسطة",
            icon: Icons.badge,
            value: item.recordedBy,
          ),
        ],
      ),
    );
  }
}