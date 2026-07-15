import 'package:flutter/material.dart';

import '../../models/cliente.dart';
import '../../services/cliente_service.dart';

class ClienteFormScreen extends StatefulWidget {
  final Cliente? cliente;

  const ClienteFormScreen({
    super.key,
    this.cliente,
  });

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

  bool get esEdicion => widget.cliente != null;

  @override
  void initState() {
    super.initState();

    if (esEdicion) {
      nombreController.text = widget.cliente!.nombre;
      empresaController.text = widget.cliente!.empresa;
      sucursalController.text = widget.cliente!.sucursal;
      direccionController.text = widget.cliente!.direccion;
      telefonoController.text = widget.cliente!.telefono;
      correoController.text = widget.cliente!.correo;
    }
  }

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
        id: esEdicion ? widget.cliente!.id : '',
        nombre: nombreController.text.trim(),
        empresa: empresaController.text.trim(),
        sucursal: sucursalController.text.trim(),
        direccion: direccionController.text.trim(),
        telefono: telefonoController.text.trim(),
        correo: correoController.text.trim(),
      );

      if (esEdicion) {
        await ClienteService().actualizarCliente(cliente);
      } else {
        await ClienteService().agregarCliente(cliente);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            esEdicion
                ? "Cliente actualizado correctamente"
                : "Cliente guardado correctamente",
          ),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      debugPrint(e.toString());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error:\n$e"),
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
        title: Text(
          esEdicion ? "Editar Cliente" : "Nuevo Cliente",
        ),
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
                      : esEdicion
                      ? "Guardar Cambios"
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