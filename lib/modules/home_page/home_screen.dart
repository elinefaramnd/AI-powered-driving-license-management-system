import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../app_theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الصفحة الرئيسية",style: TextStyle(color: Colors.white),),
      backgroundColor: AppColors.primaryColor,),
      drawer: Drawer(child: ListView(children: [
        SizedBox(height: 200,),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('الملف الشخصي'),
          onTap: () {
            Get.toNamed('/showPro');
          },
        ),
      ],),),
      body: Center(child: Text("")),);
  }
}
