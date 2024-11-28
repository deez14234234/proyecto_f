import 'package:flutter/material.dart';
import 'package:proyecto_f/pages/favoritos_page.dart';
import 'package:proyecto_f/pages/producto_form_page.dart';
import 'package:proyecto_f/pages/producto_list_page.dart';
import 'package:proyecto_f/screens/login_screen.dart'; // Importa la pantalla de login

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ProductoListPage(), // Pantalla para listar productos
    ProductoFormPage(), // Pantalla para crear un nuevo producto
    FavoritosPage(favoritos: []), // Aquí puedes agregar la lista de favoritos
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
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
        title: Text('Panel de Administración'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _logout, // Acción para cerrar sesión
          ),
        ],
      ),
      body: _screens[_selectedIndex], // Muestra la pantalla seleccionada
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Nuevo Producto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
