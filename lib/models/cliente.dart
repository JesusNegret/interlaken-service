class Cliente {
  final String id;
  final String nombre;
  final String empresa;
  final String sucursal;
  final String direccion;
  final String telefono;
  final String correo;

  const Cliente({
    required this.id,
    required this.nombre,
    required this.empresa,
    required this.sucursal,
    required this.direccion,
    required this.telefono,
    required this.correo,
  });

  factory Cliente.fromMap(String id, Map<String, dynamic> json) {
    return Cliente(
      id: id,
      nombre: json['nombre'] ?? '',
      empresa: json['empresa'] ?? '',
      sucursal: json['sucursal'] ?? '',
      direccion: json['direccion'] ?? '',
      telefono: json['telefono'] ?? '',
      correo: json['correo'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'empresa': empresa,
      'sucursal': sucursal,
      'direccion': direccion,
      'telefono': telefono,
      'correo': correo,
    };
  }

  Cliente copyWith({
    String? id,
    String? nombre,
    String? empresa,
    String? sucursal,
    String? direccion,
    String? telefono,
    String? correo,
  }) {
    return Cliente(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      empresa: empresa ?? this.empresa,
      sucursal: sucursal ?? this.sucursal,
      direccion: direccion ?? this.direccion,
      telefono: telefono ?? this.telefono,
      correo: correo ?? this.correo,
    );
  }
}