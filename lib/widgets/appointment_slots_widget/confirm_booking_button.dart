import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';

class ConfirmBookingButton extends StatelessWidget {

  final bool enabled;
  final VoidCallback onPressed;
  final bool isLoading;

  const ConfirmBookingButton({
    super.key,
    required this.enabled,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * .04,
      ),
      child: SizedBox(
        width: double.infinity,
        height: size.height * .06,
        child: ElevatedButton(
          onPressed: enabled && !isLoading
              ? onPressed
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor:
            AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(size.width * .0267),
            ),
          ),
          child: isLoading
              ? SizedBox(
            width:  size.width * .064,
            height:  size.width * .064,
            child: CircularProgressIndicator(
              strokeWidth: size.width * .0053,
              color: Colors.white,
            ),
          )
              : Text(
            "تأكيد الحجز",
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * .045,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}