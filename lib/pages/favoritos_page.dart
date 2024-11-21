import 'package:flutter/material.dart';
import '../models/producto.dart';

class FavoritosPage extends StatelessWidget {
  final List<Producto> favoritos;

  FavoritosPage({required this.favoritos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        backgroundColor: Colors.teal,
      ),
      body: favoritos.isEmpty
          ? Center(child: Text('No tienes productos favoritos.'))
          : ListView.builder(
        itemCount: favoritos.length,
        itemBuilder: (context, index) {
          final producto = favoritos[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                producto.nombre,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                '\$${producto.precio.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.green),
              ),
            ),
          );
        },
      ),
    );
  }
}
