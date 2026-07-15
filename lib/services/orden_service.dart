import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/orden_servicio.dart';

class OrdenService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _coleccion = "ordenes";

  /// Crear una nueva orden
  Future<void> agregarOrden(OrdenServicio orden) async {
    await _firestore.collection(_coleccion).add(orden.toMap());
  }

  /// Obtener todas las órdenes
  Stream<List<OrdenServicio>> obtenerOrdenes() {
    return _firestore
        .collection(_coleccion)
        .orderBy("fecha", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => OrdenServicio.fromMap(
          doc.id,
          doc.data(),
        ),
      )
          .toList(),
    );
  }

  /// Actualizar una orden
  Future<void> actualizarOrden(OrdenServicio orden) async {
    await _firestore
        .collection(_coleccion)
        .doc(orden.id)
        .update(orden.toMap());
  }

  /// Eliminar una orden
  Future<void> eliminarOrden(String id) async {
    await _firestore.collection(_coleccion).doc(id).delete();
  }
}