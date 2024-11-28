import 'package:flutter/material.dart';
import 'package:proyecto_f/pages/producto_list_page.dart';
import 'package:proyecto_f/screens/login_screen.dart'; // Importa la pantalla de login

class ClientDashboardScreen extends StatelessWidget {
  // Función de cierre de sesión
  void _logout(BuildContext context) {
    // Aquí puedes agregar la lógica para limpiar cualquier sesión o token de acceso si es necesario
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Redirige al login
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panel de Cliente'),
        actions: [
          // Icono para cerrar sesión y regresar al login
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _logout(context), // Acción para cerrar sesión
          ),
        ],
      ),
      body: ProductoListPage(), // Solo se muestra la lista de productos
    );
  }
}
