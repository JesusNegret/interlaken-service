import 'package:flutter/material.dart';

class DatosGeneralesCard extends StatelessWidget {
  final TextEditingController ticketController;
  final String tipoServicio;
  final List<String> tiposServicio;
  final ValueChanged<String?> onTipoChanged;

  const DatosGeneralesCard({
    super.key,
    required this.ticketController,
    required this.tipoServicio,
    required this.tiposServicio,
    required this.onTipoChanged,
  });

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
              "Datos Generales",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: ticketController,
              decoration: const InputDecoration(
                labelText: "Número de Ticket",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.confirmation_number),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Ingrese el número de ticket";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: tipoServicio,
              decoration: const InputDecoration(
                labelText: "Tipo de Servicio",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.build),
              ),
              items: tiposServicio
                  .map(
                    (tipo) => DropdownMenuItem(
                  value: tipo,
                  child: Text(tipo),
                ),
              )
                  .toList(),
              onChanged: onTipoChanged,
            ),
          ],
        ),
      ),
    );
  }
}