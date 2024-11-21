import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../services/producto_service.dart';
import 'producto_form_page.dart';

class ProductoDetailPage extends StatelessWidget {
  final Producto producto;
  final ProductoService _service = ProductoService();

  ProductoDetailPage({required this.producto});

  // Método para eliminar el producto
  void _deleteProducto(BuildContext context) async {
    try {
      await _service.deleteProducto(producto.id!);
      Navigator.pop(context, true); // Volver a la lista y actualizar al eliminar
    } catch (e) {
      print('Error al eliminar el producto: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(producto.nombre),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descripción: ${producto.descripcion}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Precio: \$${producto.precio.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            SizedBox(height: 8),
            Text(
              'Stock: ${producto.stock} unidades',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botón para editar el producto
                ElevatedButton.icon(
                  icon: Icon(Icons.edit),
                  label: Text('Editar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductoFormPage(producto: producto),
                      ),
                    );
                    if (result == true) {
                      Navigator.pop(context, true); // Refrescar lista si fue editado
                    }
                  },
                ),
                // Botón para eliminar el producto
                ElevatedButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text('Eliminar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    final confirm = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirmar eliminación'),
                        content: Text('¿Estás seguro de que deseas eliminar este producto?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text('Eliminar'),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      _deleteProducto(context);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
