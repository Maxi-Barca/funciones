import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/provider_puesto.dart';
import 'package:myapp/providers/providers.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final funcion = ref.watch(selectedFuncionProvider);
    final top = ref.watch(selectedFuncionIndexProvider);
    final listaActual = ref.watch(funcionesProvider);

    if (funcion == null) {
    return Scaffold(
      body: Center(child: Text('no hay funcion')),
    );
  }

    return Scaffold(
      appBar: AppBar(title: Text(funcion.funcion)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(funcion.imagenUrl),
            const SizedBox(height: 16),
            Text(funcion.descripcion),
            const SizedBox(height: 16),
            Text("TOP $top"),
            Row(
              children: [
                TextButton(
                onPressed: () {
                context.go('/edit');
               },
              child: Text("Editar"),
              ),
                TextButton(
                onPressed: () {
                  final nuevaLista = [...listaActual];
                  nuevaLista.remove(funcion);

                  ref.read(funcionesProvider.notifier).state = nuevaLista;
                  ref.read(selectedFuncionProvider.notifier).state = null;
                  context.pop();
                },
                  child: Text("Borrar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}