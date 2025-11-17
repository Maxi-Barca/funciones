import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: const Text("Mi Perfil")),
      body: FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('user').doc(uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data()!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(data['imagenUrl']),
                ),
                const SizedBox(height: 20),
                Text("Nombre: ${data['nombre']}", style: const TextStyle(fontSize: 18)),
                Text("Email: ${data['mail']}", style: const TextStyle(fontSize: 18)),
                Text("Dirección: ${data['direccion']}", style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
  
                ElevatedButton(
                  onPressed: () => context.push('/editarPerfil'),
                  child: const Text("Editar Perfil"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}