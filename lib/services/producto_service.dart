import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/producto.dart';

class ProductoService {
  static const String apiUrl = 'http://10.0.2.2:8000/api/productos';  // Update to local IP if on a real device.

  // Fetch all productos from the API
  Future<List<Producto>> fetchProductos() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      // Check response status
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');  // Print API response

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Producto.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load productos. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching productos: $e');
      rethrow;  // Re-throw the exception to handle it at the calling level
    }
  }

  // Create a new producto
  Future<void> createProducto(Producto producto) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(producto.toJson()),  // JSON encode product data
      );

      // Check creation response
      if (response.statusCode == 201) {
        print('Producto created successfully');
      } else {
        throw Exception('Failed to create producto. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating producto: $e');
      rethrow;  // Propagate the error upwards
    }
  }

  // Update an existing producto by ID
  Future<void> updateProducto(int id, Producto producto) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(producto.toJson()),  // JSON encode product data
      );

      // Check update response
      if (response.statusCode == 200) {
        print('Producto updated successfully');
      } else {
        throw Exception('Failed to update producto. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating producto: $e');
      rethrow;  // Propagate the error upwards
    }
  }

  // Delete an existing producto by ID
  Future<void> deleteProducto(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));

      // Check deletion response
      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Producto deleted successfully');
      } else {
        throw Exception('Failed to delete producto. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting producto: $e');
      rethrow;  // Propagate the error upwards
    }
  }
}
