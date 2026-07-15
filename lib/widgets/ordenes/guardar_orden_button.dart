import 'package:flutter/material.dart';

class GuardarOrdenButton extends StatelessWidget {
  final bool guardando;
  final VoidCallback onPressed;

  const GuardarOrdenButton({
    super.key,
    required this.guardando,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: guardando ? null : onPressed,
        icon: guardando
            ? const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : const Icon(Icons.save),
        label: Text(
          guardando
              ? "Guardando..."
              : "Guardar Orden de Servicio",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}