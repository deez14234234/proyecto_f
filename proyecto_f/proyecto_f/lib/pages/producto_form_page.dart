import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../services/producto_service.dart';

class ProductoFormPage extends StatefulWidget {
  final Producto? producto;
  ProductoFormPage({this.producto});

  @override
  _ProductoFormPageState createState() => _ProductoFormPageState();
}

class _ProductoFormPageState extends State<ProductoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final ProductoService _service = ProductoService();

  // Variables para almacenar los valores del formulario
  late String nombre;
  late String descripcion;
  late double precio;
  late int stock;

  @override
  void initState() {
    super.initState();
    // Si el producto existe, inicializamos los campos con sus valores
    nombre = widget.producto?.nombre ?? '';
    descripcion = widget.producto?.descripcion ?? '';
    precio = widget.producto?.precio ?? 0.0;
    stock = widget.producto?.stock ?? 0;
  }

  // Función para guardar el producto
  Future<void> _saveProducto() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final producto = Producto(
        id: widget.producto?.id,
        nombre: nombre,
        descripcion: descripcion,
        precio: precio,
        stock: stock,
      );

      if (widget.producto == null) {
        // Crear un nuevo producto
        await _service.createProducto(producto);
      } else {
        // Actualizar el producto existente
        await _service.updateProducto(producto.id!, producto);
      }

      // Navegar de regreso a la lista de productos después de guardar
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.producto == null ? 'Nuevo Producto' : 'Editar Producto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: nombre,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un nombre';
                  }
                  return null;
                },
                onSaved: (value) => nombre = value!,
              ),
              TextFormField(
                initialValue: descripcion,
                decoration: InputDecoration(labelText: 'Descripción'),
                onSaved: (value) => descripcion = value!,
              ),
              TextFormField(
                initialValue: precio.toString(),
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Por favor, ingrese un precio válido';
                  }
                  return null;
                },
                onSaved: (value) => precio = double.parse(value!),
              ),
              TextFormField(
                initialValue: stock.toString(),
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Por favor, ingrese una cantidad de stock válida';
                  }
                  return null;
                },
                onSaved: (value) => stock = int.parse(value!),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _saveProducto,
                    child: Text(widget.producto == null ? 'Crear' : 'Actualizar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
