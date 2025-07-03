import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/entities/funciones.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/providers.dart';

class AgregarScreen extends ConsumerWidget {
  const AgregarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController textController1 = TextEditingController();
    TextEditingController textController2 = TextEditingController();
    TextEditingController textController3 = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Agregar Función')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Agrega una nueva función', style: TextStyle(fontSize: 35)),
            const SizedBox(height: 20),
            Text('Nombre:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextField(controller: textController1),
            const SizedBox(height: 20),
            Text('Descripción:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextField(controller: textController2),
            const SizedBox(height: 20),
            Text('Url de imagen:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextField(controller: textController3),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                final nuevaFuncion = Funcion(
                  funcion: textController1.text,
                  imagenUrl: textController3.text,
                  descripcion: textController2.text,
                );

                final copia = [...ref.read(funcionesProvider)];
                copia.add(nuevaFuncion);
                ref.read(funcionesProvider.notifier).state = copia;

                context.go('/home');
              },
              child: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
