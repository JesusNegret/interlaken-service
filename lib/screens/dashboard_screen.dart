import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/info_usuario.dart';
import '../widgets/menu_card.dart';
import '../screens/clientes/clientes_screen.dart';
import 'login_screen.dart';
import 'ordenes/orden_form_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = FirebaseAuth.instance.currentUser;

    final nombre = (usuario?.displayName != null &&
        usuario!.displayName!.isNotEmpty)
        ? usuario.displayName!
        : "Administrador";

    final correo = usuario?.email ?? "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Interlaken Service"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Cerrar sesión",
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              if (!context.mounted) return;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InfoUsuario(
              nombre: nombre,
              correo: correo,
            ),

            const SizedBox(height: 25),

            MenuCard(
              icono: Icons.assignment,
              titulo: "Nueva Orden de Servicio",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OrdenFormScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            MenuCard(
              icono: Icons.list_alt,
              titulo: "Consultar Órdenes",
              onTap: () {},
            ),

            const SizedBox(height: 15),

            MenuCard(
              icono: Icons.people,
              titulo: "Clientes",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ClientesScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            MenuCard(
              icono: Icons.business,
              titulo: "Sucursales",
              onTap: () {},
            ),

            const SizedBox(height: 15),

            MenuCard(
              icono: Icons.engineering,
              titulo: "Técnicos",
              onTap: () {},
            ),

            const SizedBox(height: 15),

            MenuCard(
              icono: Icons.precision_manufacturing,
              titulo: "Equipos",
              onTap: () {},
            ),

            const SizedBox(height: 15),

            MenuCard(
              icono: Icons.bar_chart,
              titulo: "Reportes",
              onTap: () {},
            ),

            const SizedBox(height: 15),

            MenuCard(
              icono: Icons.settings,
              titulo: "Configuración",
              onTap: () {},
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}