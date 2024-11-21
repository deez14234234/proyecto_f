import 'package:proyecto_f/models/producto.dart';

class Carrito {
  List<Producto> productos;

  Carrito({this.productos = const []});

  void agregarProducto(Producto producto) {
    productos.add(producto);
  }

  void eliminarProducto(Producto producto) {
    productos.removeWhere((item) => item.id == producto.id);
  }

  double obtenerTotal() {
    return productos.fold(0, (total, producto) => total + producto.precio);
  }
}
