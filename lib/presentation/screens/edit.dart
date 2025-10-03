import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/provider_puesto.dart';
import 'package:myapp/providers/providers.dart';

class EditScreen extends ConsumerWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final funcion = ref.watch(selectedFuncionProvider);
    
    if (funcion == null) {
    return Scaffold(
      body: Center(child: Text('no hay funcion')),
    );
  }

    final nombre = TextEditingController(text: funcion.funcion);
    final descripcion = TextEditingController(text: funcion.descripcion);
    final imagenUrl = TextEditingController(text: funcion.imagenUrl);


    return Scaffold(
      appBar: AppBar(title: Text('Editar Función')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Edita la función', style: TextStyle(fontSize: 35)),
            const SizedBox(height: 20),
            Text('Nombre:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextField(controller: nombre),
            const SizedBox(height: 20),
            Text('Descripción:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextField(controller: descripcion),
            const SizedBox(height: 20),
            Text('Url de imagen:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextField(controller: imagenUrl),
            SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                final nuevaFuncion = funcion.copyWith(
                  funcion: nombre.text,
                  descripcion: descripcion.text,
                  imagenUrl: imagenUrl.text,
                );

                await ref.read(funcionesProvider.notifier).editarFuncion(nuevaFuncion);

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
