import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/provider_puesto.dart';
import 'package:myapp/providers/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    ref.read(funcionesProvider.notifier).getAllFunciones();
  });
}

  @override
  Widget build(BuildContext context) {
    final listaFunciones = ref.watch(funcionesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Funciones Matemáticas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/perfil'),
          )
        ],
      ),

      body: listaFunciones.isEmpty
          ? const Center(child: Text("No tienes funciones aún"))
          : ListView.builder(
              itemCount: listaFunciones.length,
              itemBuilder: (context, index) {
                final funcion = listaFunciones[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: Image.network(
                      funcion.imagenUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(funcion.funcion),
                    subtitle: Text("Función ${index + 1}"),
                    onTap: () {
                      ref.read(selectedFuncionProvider.notifier).state = funcion;
                      ref.read(selectedFuncionIndexProvider.notifier).state = index + 1;
                      context.push('/detail');
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/agregar'),
        child: const Icon(Icons.add),
      ),
    );
  }
}