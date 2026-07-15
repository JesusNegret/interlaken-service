import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/cliente.dart';
import '../../models/orden_servicio.dart';
import '../../services/cliente_service.dart';
import '../../services/orden_service.dart';

import '../../widgets/ordenes/datos_generales_card.dart';
import '../../widgets/ordenes/descripcion_servicio_card.dart';
import '../../widgets/ordenes/guardar_orden_button.dart';
import '../../widgets/ordenes/observaciones_card.dart';

class OrdenFormScreen extends StatefulWidget {
  const OrdenFormScreen({super.key});

  @override
  State<OrdenFormScreen> createState() => _OrdenFormScreenState();
}

class _OrdenFormScreenState extends State<OrdenFormScreen> {
final _formKey = GlobalKey<FormState>();

final ClienteService _clienteService = ClienteService();
final OrdenService _ordenService = OrdenService();

final ticketController = TextEditingController();
final diagnosticoController = TextEditingController();
final trabajoController = TextEditingController();
final materialesController = TextEditingController();
final observacionesController = TextEditingController();

bool guardando = false;

Cliente? clienteSeleccionado;

String tipoServicio = "Correctivo";

final List<String> tiposServicio = [
"Correctivo",
"Preventivo",
"Instalación",
"Garantía",
"Diagnóstico",
];

@override
void dispose() {
ticketController.dispose();
diagnosticoController.dispose();
trabajoController.dispose();
materialesController.dispose();
observacionesController.dispose();
super.dispose();
}

Future<void> guardarOrden() async {
if (!_formKey.currentState!.validate()) return;

if (clienteSeleccionado == null) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("Seleccione un cliente"),
),
);
return;
}

try {
setState(() {
guardando = true;
});

final usuario = FirebaseAuth.instance.currentUser;

final orden = OrdenServicio(
id: "",
clienteId: clienteSeleccionado!.id,
clienteNombre: clienteSeleccionado!.nombre,
ticket: ticketController.text.trim(),
tipoServicio: tipoServicio,
diagnostico: diagnosticoController.text.trim(),
trabajoRealizado: trabajoController.text.trim(),
materiales: materialesController.text.trim(),
observaciones: observacionesController.text.trim(),
tecnico: usuario?.displayName ?? "Administrador",
fecha: DateTime.now(),
);

await _ordenService.agregarOrden(orden);

if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
backgroundColor: Colors.green,
content: Text("Orden guardada correctamente"),
),
);

Navigator.pop(context);
} catch (e) {
if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
backgroundColor: Colors.red,
content: Text(e.toString()),
),
);
} finally {
if (mounted) {
setState(() {
guardando = false;
});
}
}
}

@override