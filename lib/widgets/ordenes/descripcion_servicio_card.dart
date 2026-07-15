import 'package:flutter/material.dart';

class DescripcionServicioCard extends StatelessWidget {
  final TextEditingController diagnosticoController;
  final TextEditingController trabajoController;
  final TextEditingController materialesController;

  const DescripcionServicioCard({
    super.key,
    required this.diagnosticoController,
    required this.trabajoController,
    required this.materialesController,
  });

  Widget campo(
      TextEditingController controller,
      String titulo,
      IconData icono,
      int lineas,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        maxLines: lineas,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Campo obligatorio";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: titulo,
          prefixIcon: Icon(icono),
          border: const OutlineInputBorder(),
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Descripción del Servicio",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            campo(
              diagnosticoController,
              "Diagnóstico",
              Icons.search,
              4,
            ),

            campo(
              trabajoController,
              "Trabajo realizado",
              Icons.build,
              4,
            ),

            campo(
              materialesController,
              "Material utilizado",
              Icons.inventory_2,
              3,
            ),
          ],
        ),
      ),
    );
  }
}