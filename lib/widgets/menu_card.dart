import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.icono,
    required this.titulo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                icono,
                size: 36,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}