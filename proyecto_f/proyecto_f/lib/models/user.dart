class User {
  final int id;             // Nuevo campo id
  final String email;
  final String role;
  final String name;        // Campo adicional 'name' para el nombre del usuario
  final bool isActive;      // Campo adicional 'isActive' para indicar si el usuario está activo
  final DateTime createdAt; // Fecha de creación del usuario

  // Constructor de la clase User
  User({
    required this.id,
    required this.email,
    required this.role,
    required this.name,
    required this.isActive,
    required this.createdAt,
  });

  // Método de fábrica para convertir un Map de la respuesta JSON a un objeto User
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'],                  // Asumiendo que 'id' es un campo en tu base de datos
      email: data['email'],            // El 'email' que viene del JSON
      role: data['role'],              // El 'role' que viene del JSON
      name: data['name'] ?? '',        // Si 'name' está en el JSON, lo toma, si no, lo asigna como vacío
      isActive: data['is_active'] ?? true, // Si 'is_active' está en el JSON, lo toma, si no, lo asigna como true
      createdAt: DateTime.parse(data['created_at']), // Convierte el campo 'created_at' en un DateTime
    );
  }

  // Método para convertir un objeto User a JSON (para hacer POST o PUT)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'name': name,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),  // Convierte la fecha a formato ISO 8601
    };
  }
}
