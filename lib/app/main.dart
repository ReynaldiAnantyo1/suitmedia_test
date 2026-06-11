import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:suitmedia_test/app/modules/firstScreen/views/firstScreenView.dart';
import 'package:suitmedia_test/app/modules/secondScreen/views/secondScreenView.dart';
import 'package:suitmedia_test/app/modules/thirdScreen/thirdScreenView.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Suitmedia',
      initialRoute: '/first',
      getPages: [
        GetPage(name: '/first', page: () => FirstScreen()),
        GetPage(name: '/second', page: () => SecondScreen()),
        GetPage(name: '/third', page: () => ThirdScreen()),
      ],
    );
  }
}
