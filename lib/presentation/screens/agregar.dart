import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/entities/funciones.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/providers.dart';

class AgregarScreen extends ConsumerWidget {
  const AgregarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController1 = TextEditingController();
    final textController2 = TextEditingController();
    final textController3 = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Función')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text('Agrega una nueva función', style: TextStyle(fontSize: 30)),
              const SizedBox(height: 20),
              const Text('Nombre:', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextField(controller: textController1),
              const SizedBox(height: 20),
              const Text('Descripción:', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextField(controller: textController2, maxLines: 3),
              const SizedBox(height: 20),
              const Text('URL de imagen:', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextField(controller: textController3),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final nuevaFuncion = Funcion(
                    funcion: textController1.text,
                    imagenUrl: textController3.text,
                    descripcion: textController2.text,
                  );

                  await ref.read(funcionesProvider.notifier).addFuncion(nuevaFuncion);

                  context.go('/home');
                },
                child: const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}