import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000/api';
// Método para registrar un usuario
  Future<Map<String, dynamic>> registerUser(String name, String email, String password, String passwordConfirm, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirm,
        'role': role,
      },
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al registrar usuario: ${response.body}');
    }
  }
}