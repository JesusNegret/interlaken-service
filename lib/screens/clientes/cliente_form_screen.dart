import 'package:flutter/material.dart';

import '../../models/cliente.dart';
import '../../services/cliente_service.dart';

class ClienteFormScreen extends StatefulWidget {
  const ClienteFormScreen({super.key});

  @override
  State<ClienteFormScreen> createState() => _ClienteFormScreenState();
}

class _ClienteFormScreenState extends State<ClienteFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final nombreController = TextEditingController();
  final empresaController = TextEditingController();
  final sucursalController = TextEditingController();
  final direccionController = TextEditingController();
  final telefonoController = TextEditingController();
  final correoController = TextEditingController();

  bool guardando = false;

  @override
  void dispose() {
    nombreController.dispose();
    empresaController.dispose();
    sucursalController.dispose();
    direccionController.dispose();
    telefonoController.dispose();
    correoController.dispose();
    super.dispose();
  }

  Future<void> guardarCliente() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() {
        guardando = true;
      });

      final cliente = Cliente(
        id: '',
        nombre: nombreController.text.trim(),
        empresa: empresaController.text.trim(),
        sucursal: sucursalController.text.trim(),
        direccion: direccionController.text.trim(),
        telefono: telefonoController.text.trim(),
        correo: correoController.text.trim(),
      );

      await ClienteService().agregarCliente(cliente);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cliente guardado correctamente"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      debugPrint("ERROR FIRESTORE: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error al guardar:\n$e"),
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

  Widget campo(TextEditingController controller, String titulo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Campo obligatorio";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: titulo,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo Cliente"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              campo(nombreController, "Nombre"),
              campo(empresaController, "Empresa"),
              campo(sucursalController, "Sucursal"),
              campo(direccionController, "Dirección"),
              campo(telefonoController, "Teléfono"),
              campo(correoController, "Correo"),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: Text(
                  guardando
                      ? "Guardando..."
                      : "Guardar Cliente",
                ),
                onPressed: guardando ? null : guardarCliente,
              ),
            ],
          ),
        ),
      ),
    );
  }
}