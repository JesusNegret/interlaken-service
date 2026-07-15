import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cliente.dart';

class ClienteService {

  final CollectionReference<Map<String, dynamic>> _clientes =
  FirebaseFirestore.instance.collection('clientes');

  /// Crear
  Future<void> agregarCliente(Cliente cliente) async {
    await _clientes.add(cliente.toMap());
  }

  /// Leer
  Stream<List<Cliente>> obtenerClientes() {
    return _clientes.snapshots().map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => Cliente.fromMap(
          doc.id,
          doc.data(),
        ),
      )
          .toList(),
    );
  }

  /// Actualizar
  Future<void> actualizarCliente(Cliente cliente) async {
    await _clientes.doc(cliente.id).update(cliente.toMap());
  }

  /// Eliminar
  Future<void> eliminarCliente(String id) async {
    await _clientes.doc(id).delete();
  }

  /// Obtener un cliente por ID
  Future<Cliente?> obtenerCliente(String id) async {
    final doc = await _clientes.doc(id).get();

    if (!doc.exists) return null;

    return Cliente.fromMap(
      doc.id,
      doc.data()!,
    );
  }
}