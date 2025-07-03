import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/provider_puesto.dart';
import 'package:myapp/providers/providers.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  
  @override
  Widget build(BuildContext context, ref) {
    final listaFunciones = ref.watch(funcionesProvider); 

    return Scaffold(
      appBar: AppBar(title: const Text('TOP DE MEJORES FUNCIONES MATEMÁTICAS')),
      body: ListView.builder(

        itemCount: listaFunciones.length,
        itemBuilder: (context, index) {
          final funcion = listaFunciones[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              // Define el margen exterior de la tarjeta
              horizontal: 12, // Espacio a los lados (izquierda y derecha)
              vertical: 6, // Espacio arriba y abajo
            ),

            child: ListTile(
              // ListTile es un widget que organiza contenido en una fila con íconos, texto, etc.
              contentPadding: const EdgeInsets.all(
                8,
              ), // Relleno interno del ListTile (espacio dentro)
              leading: Image.network(
                // Imagen que aparece al inicio del ListTile (a la izquierda)
                funcion.imagenUrl,
                width: 200,
                height: 200,
                fit:
                    BoxFit.cover, // Ajuste de la imagen: se recorta para cubrir el área sin deformarse
              ),
              title: Text(funcion.funcion),
              subtitle: Text("TOP ${index + 1}"),
              onTap: () {
                ref.read(selectedFuncionProvider.notifier).state = funcion;
                ref.read(selectedFuncionIndexProvider.notifier).state =
                    index + 1;
                context.push('/detail');
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/agregar');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
