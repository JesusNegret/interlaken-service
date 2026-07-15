import 'package:flutter/material.dart';

class ObservacionesCard extends StatelessWidget {
  final TextEditingController observacionesController;

  const ObservacionesCard({
    super.key,
    required this.observacionesController,
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
              "Observaciones",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: observacionesController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Observaciones finales",
                hintText: "Escriba aquí comentarios adicionales...",
                prefixIcon: Icon(Icons.note_alt),
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}