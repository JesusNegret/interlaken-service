class OrdenServicio {
  final String id;

  final String clienteId;
  final String clienteNombre;

  final String ticket;
  final String tipoServicio;

  final String diagnostico;
  final String trabajoRealizado;
  final String materiales;
  final String observaciones;

  final String tecnico;

  final DateTime fecha;

  OrdenServicio({
    required this.id,
    required this.clienteId,
    required this.clienteNombre,
    required this.ticket,
    required this.tipoServicio,
    required this.diagnostico,
    required this.trabajoRealizado,
    required this.materiales,
    required this.observaciones,
    required this.tecnico,
    required this.fecha,
  });

  Map<String, dynamic> toMap() {
    return {
      "clienteId": clienteId,
      "clienteNombre": clienteNombre,
      "ticket": ticket,
      "tipoServicio": tipoServicio,
      "diagnostico": diagnostico,
      "trabajoRealizado": trabajoRealizado,
      "materiales": materiales,
      "observaciones": observaciones,
      "tecnico": tecnico,
      "fecha": fecha,
    };
  }

  factory OrdenServicio.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return OrdenServicio(
      id: id,
      clienteId: map["clienteId"] ?? "",
      clienteNombre: map["clienteNombre"] ?? "",
      ticket: map["ticket"] ?? "",
      tipoServicio: map["tipoServicio"] ?? "",
      diagnostico: map["diagnostico"] ?? "",
      trabajoRealizado: map["trabajoRealizado"] ?? "",
      materiales: map["materiales"] ?? "",
      observaciones: map["observaciones"] ?? "",
      tecnico: map["tecnico"] ?? "",
      fecha: map["fecha"].toDate(),
    );
  }
}