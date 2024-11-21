import 'package:flutter/material.dart';
import 'pages/producto_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Ventas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductoListPage(),
    );
  }
}
