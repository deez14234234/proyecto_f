import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../services/producto_service.dart';
import 'producto_detail_page.dart';
import 'producto_form_page.dart';

class ProductoListPage extends StatefulWidget {
  @override
  _ProductoListPageState createState() => _ProductoListPageState();
}

class _ProductoListPageState extends State<ProductoListPage> {
  final ProductoService _service = ProductoService();
  late Future<List<Producto>> _productos;

  @override
  void initState() {
    super.initState();
    _fetchProductos(); // Cargar productos al iniciar la página
  }

  // Método para obtener productos y actualizar el futuro
  void _fetchProductos() {
    setState(() {
      _productos = _service.fetchProductos();
    });
  }

  // Método para eliminar un producto
  void _deleteProducto(int id) async {
    try {
      await _service.deleteProducto(id);
      _fetchProductos(); // Actualizar la lista después de eliminar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto eliminado correctamente')),
      );
    } catch (e) {
      print('Error al eliminar el producto: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar el producto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Productos'),
        centerTitle: true,
        backgroundColor: Colors.teal, // Color personalizado para el AppBar
      ),
      body: FutureBuilder<List<Producto>>(
        future: _productos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 40),
                  SizedBox(height: 10),
                  Text('Error al cargar los productos', style: TextStyle(color: Colors.red, fontSize: 18)),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('No hay productos disponibles.'));
          } else {
            final productos = snapshot.data!;
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
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
                    leading: Icon(Icons.shopping_cart, color: Colors.teal),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        // Confirmación para eliminar el producto
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
                          _deleteProducto(producto.id!); // Llamar a eliminar si se confirma
                        }
                      },
                    ),
                    onTap: () async {
                      // Navegar a la página de detalles y esperar un resultado
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductoDetailPage(producto: producto),
                        ),
                      );
                      if (result == true) {
                        _fetchProductos(); // Refrescar la lista si hubo una actualización
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navegar a la página de formulario y esperar el resultado
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductoFormPage()),
          );

          // Refrescar la lista de productos si se creó o actualizó uno
          if (result == true) {
            _fetchProductos();
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
        tooltip: 'Agregar Producto',
      ),
    );
  }
}
