class Producto {
  final int? id;
  final String nombre;
  final String descripcion;
  final double precio;
  final int stock;
  bool esFavorito;  // Agregado para manejar el estado de favorito

  Producto({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.stock,
    this.esFavorito = false,  // Valor por defecto en falso
  });

  // Factory method to create a Producto from JSON
  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],  // 'id' puede ser nulo o un número
      nombre: json['nombre'] ?? '',  // Default a cadena vacía si es nulo
      descripcion: json['descripcion'] ?? '',  // Default a cadena vacía si es nulo
      precio: _parsePrecio(json['precio']),  // Maneja el tipo y conversión del precio
      stock: json['stock'] ?? 0,  // Default stock a 0 si es nulo
      esFavorito: json['esFavorito'] ?? false,  // Default a falso si no está presente
    );
  }

  // Helper method to handle precio conversion
  static double _parsePrecio(dynamic precio) {
    if (precio is String) {
      return double.tryParse(precio) ?? 0.0;  // Si no se puede parsear, retorna 0.0
    } else if (precio is double) {
      return precio;
    }
    return 0.0;  // Si no es ni String ni double, retorna 0.0
  }

  // Convert Producto object to JSON
  Map<String, dynamic> toJson() => {
    'id': id,  // id puede ser nulo, lo manejamos correctamente
    'nombre': nombre,
    'descripcion': descripcion,
    'precio': precio.toString(),  // Aseguramos que el precio sea una cadena para la API (si es necesario)
    'stock': stock,
    'esFavorito': esFavorito,  // Guardamos el estado de favorito en JSON
  };

  // Método para actualizar el estado de favorito
  void toggleFavorito() {
    esFavorito = !esFavorito;
  }
}
