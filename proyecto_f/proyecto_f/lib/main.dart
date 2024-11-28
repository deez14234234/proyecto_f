import 'package:flutter/material.dart';
import 'package:proyecto_f/screens/login_screen.dart';
import 'package:proyecto_f/screens/register_screen.dart';
import 'package:proyecto_f/screens/admin_dashboard_screen.dart'; // Pantalla Admin
import 'package:proyecto_f/screens/client_dashboard_screen.dart'; // Pantalla Cliente

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Proyecto',
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => LoginScreen(), // Ruta del login
        '/register': (context) => RegisterScreen(), // Ruta de registro
        '/admin_dashboard': (context) => AdminDashboardScreen(), // Ruta del panel de administración
        '/client_dashboard': (context) => ClientDashboardScreen(), // Ruta del panel de cliente
      },
    );
  }
}
