import 'package:flutter/material.dart';

import '../../models/cliente.dart';
import '../../services/cliente_service.dart';
import 'cliente_form_screen.dart';

class ClientesScreen extends StatelessWidget {
  const ClientesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
      ),

      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.person_add),
        label: const Text("Nuevo Cliente"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ClienteFormScreen(),
            ),
          );
        },
      ),

      body: StreamBuilder<List<Cliente>>(
        stream: ClienteService().obtenerClientes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final clientes = snapshot.data ?? [];

          if (clientes.isEmpty) {
            return const Center(
              child: Text(
                "Aún no hay clientes registrados",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: clientes.length,
            itemBuilder: (context, index) {
              final cliente = clientes[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),

                  leading: const CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.person),
                  ),

                  title: Text(
                    cliente.nombre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cliente.empresa),
                        Text(cliente.sucursal),
                        Text(cliente.telefono),
                      ],
                    ),
                  ),

                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == "editar") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Editar cliente (próximamente)",
                            ),
                          ),
                        );
                      }

                      if (value == "eliminar") {
                        final eliminar = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Eliminar cliente"),
                              content: Text(
                                "¿Desea eliminar a ${cliente.nombre}?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text("Cancelar"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text("Eliminar"),
                                ),
                              ],
                            );
                          },
                        );

                        if (eliminar == true) {
                          await ClienteService().eliminarCliente(cliente.id);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Cliente eliminado"),
                              ),
                            );
                          }
                        }
                      }
                    },

                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: "editar",
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 10),
                            Text("Editar"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "eliminar",
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Text("Eliminar"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}