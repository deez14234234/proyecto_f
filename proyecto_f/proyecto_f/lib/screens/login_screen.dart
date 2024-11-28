import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proyecto_f/screens/register_screen.dart'; // Asegúrate de importar la pantalla de registro
import 'package:proyecto_f/screens/admin_dashboard_screen.dart'; // Pantalla admin
import 'package:proyecto_f/screens/client_dashboard_screen.dart'; // Pantalla cliente

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/login'),
      body: {
        'email': _emailController.text,
        'password': _passwordController.text,
      },
    );

    final responseData = json.decode(response.body);
    print(responseData);  // Imprime toda la respuesta para verificar

    if (response.statusCode == 200) {
      // Verifica si el rol se está enviando correctamente
      print("Rol recibido: ${responseData['user']['role']}");

      if (responseData['user']['role'] == 'admin') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login exitoso, bienvenido admin'),
        ));
        Navigator.pushReplacementNamed(context, '/admin_dashboard');
      } else if (responseData['user']['role'] == 'cliente') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login exitoso, bienvenido cliente'),
        ));
        Navigator.pushReplacementNamed(context, '/client_dashboard');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Rol no reconocido'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(responseData['message']),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Iniciar sesión'),
            ),
            SizedBox(height: 20),
            // Aquí agregamos el enlace de registro
            TextButton(
              onPressed: () {
                // Redirige al formulario de registro
                Navigator.pushNamed(context, '/register');
              },
              child: Text('¿No tienes cuenta? Regístrate aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
