import 'package:flutter/material.dart';
class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.39,
      padding: EdgeInsets.all(size.width * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "طلبك الحالي",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.039,
                  ),
                ),
                Text(
                  "إصدار رخصة قيادة خاصة",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.04,
                  ),
                ),
                SizedBox(height: size.height * 0.008),
                Text(
                  "رقم الطلب: APP-2026-123456",
                  style: TextStyle(
                    fontSize: size.width * 0.036,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Divider(),
                Text(
                  "الحالة الحالية",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.039,
                  ),
                ),
                Text(
                  "بانتظار دفع الرسوم",
                  style: TextStyle(
                    color: const Color(0xff988561),
                    fontSize: size.width * 0.035,
                  ),
                ),
                SizedBox(height: size.height * 0.008),
                Text(
                  "الخطوة التالية",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.039,
                  ),
                ),
                Text(
                  "يرجى دفع الرسوم المطلوبة للانتقال للمرحلة التالية",
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: size.width * 0.47,
                  height: size.height * 0.055,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff054239),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(size.width * 0.03),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.credit_card_outlined,
                          color: Colors.white,
                          size: size.width * 0.06,
                        ),
                        SizedBox(width: size.width * 0.045),

                        Text(
                          "دفع الرسوم الآن",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),

          Positioned(
            top: size.height * 0.01,
            left: 0,
            child: Image.asset(
              "assets/images/car.png",
              width: size.width * 0.5,
              height: size.height * 0.25,
            ),
          ),
        ],
      ),
    );
  }
}