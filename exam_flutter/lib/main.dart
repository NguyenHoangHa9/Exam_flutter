import 'package:exam_flutter/place.dart';
import 'package:flutter/material.dart';

import 'database.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();

  // Thêm dữ liệu mẫu
  await dbHelper.insertPlace(Place(name: 'Ha Noi', imageUrl: 'assets/images/hanoi.jpeg'));
  await dbHelper.insertPlace(Place(name: 'Sai Gon', imageUrl: 'assets/images/saigon.jpeg'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}