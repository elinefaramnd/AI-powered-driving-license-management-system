import 'package:flutter/material.dart';
import '../app_theme/app_colors.dart';

class ServicesGridWidget extends StatelessWidget {
  const ServicesGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final services = [
      {
        "icon": Icons.note_add_outlined,
        "title": "إصدار رخصة جديدة",
        "desc": "ابدأ طلب إصدار رخصة قيادة لأول مرة",
      },
      {
        "icon": Icons.autorenew,
        "title": "تجديد رخصة",
        "desc": "جدد رخصتك الحالية بسهولة",
      },
      {
        "icon": Icons.sync,
        "title": "بدل فاقد / تالف",
        "desc": "اطلب نسخة بديلة عن رخصتك",
      },
      {
        "icon": Icons.lock_open_outlined,
        "title": "فك حجز رخصة",
        "desc": "تابع طلب فك الحجز بعد معالجة السبب",
      },
      {
        "icon": Icons.calendar_month_outlined,
        "title": "حجز موعد",
        "desc": "احجز موعد لاختبار القيادة",
      },
      {
        "icon": Icons.credit_card_outlined,
        "title": "الدفع الإلكتروني",
        "desc": "دفع الرسوم بسهولة وأمان",
      },
      {
        "icon": Icons.confirmation_num_outlined,
        "title": "غراماتي",
        "desc": "عرض الغرامات ومتابعتها",
      },
      {
        "icon": Icons.assignment_outlined,
        "title": "اختباراتي ونتائجي",
        "desc": "عرض نتائج الاختبارات",
      },
      {
        "icon": Icons.event_note_outlined,
        "title": "مواعيدي",
        "desc": "عرض وتعديل المواعيد",
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.02),
              child: Icon(
                Icons.grid_view,
                color: AppColors.primaryColor,
                size: w * 0.05,
              ),
            ),
            Text(
              "الخدمات المرورية",
              style: TextStyle(
                fontSize: w * 0.043,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: h * 0.005),
        SizedBox(
          height: h * 0.20,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            reverse: true,
            separatorBuilder: (_, __) => SizedBox(width: w * 0.017),
            itemBuilder: (_, i) {
              final service = services[i];
              return Container(
                width: w * 0.36,
                padding: EdgeInsets.all(w * 0.035),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.045),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: h * 0.04,
                      width: h * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green.withOpacity(0.2),
                      ),
                      child: Icon(
                        service["icon"] as IconData,
                        color: AppColors.darkGreen,
                        size: w * 0.07,
                      ),
                    ),

                    SizedBox(height: h * 0.01),

                    Text(
                      service["title"] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.035,
                        color: AppColors.darkGreen,
                      ),
                    ),
                    SizedBox(height: h * 0.005),
                    Text(
                      service["desc"] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: w * 0.028,
                        height: h*0.002,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}