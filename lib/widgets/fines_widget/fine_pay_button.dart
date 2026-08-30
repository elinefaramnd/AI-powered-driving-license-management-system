import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../app_theme/app_colors.dart';
import '../../../widgets/app_snackbar.dart';
import '../../modules/fines/fine_details_controller.dart';

class FinePayButton extends StatelessWidget {
  final FineDetailsController controller;
  final double amount;
  final String currency;

  const FinePayButton({
    super.key,
    required this.controller,
    required this.amount,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(w * .045, w * .025, w * .045, w * .035),
        child: SizedBox(
          width: double.infinity,
          height: w * .14,
          child: Obx(() {
            final loading = controller.isCreatingPayment.value;

            return ElevatedButton(
              onPressed: loading ? null : _pay,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * .035),
                ),
              ),
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      '${"pay_now".tr} '
                      '${amount.toStringAsFixed(2)} '
                      '$currency',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * .04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> _pay() async {
    final success = await controller.createPayment();

    if (!success) return;

    controller.startStatusCheck();

    AppSnackbar.show("verifying".tr, "verifying_payment_status".tr);
  }
}
