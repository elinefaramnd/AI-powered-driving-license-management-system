import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../app_theme/app_colors.dart';

class PaymentBottomBar extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const PaymentBottomBar({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final w=size.width;
    final h=size.height;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(w*.035),
        child: SizedBox(
          height: h*.067,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w*.03),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_outline, size: w*.045),
                      SizedBox(width: w*.015),
                       Text(
                        "pay_now".tr,
                        style: TextStyle(
                          fontSize:w*.042,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
