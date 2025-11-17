import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class EditarPerfilScreen extends StatefulWidget {
  const EditarPerfilScreen({super.key});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  final nombreCtrl = TextEditingController();
  final direccionCtrl = TextEditingController();
  final imagenCtrl = TextEditingController();

  bool cargando = true;
  String mensaje = '';

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();

    final data = doc.data()!;

    nombreCtrl.text = data['nombre'];
    direccionCtrl.text = data['direccion'];
    imagenCtrl.text = data['imagenUrl'];

    setState(() {
      cargando = false;
    });
  }

  Future<void> guardarCambios() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final nombre = nombreCtrl.text.trim();
    final direccion = direccionCtrl.text.trim();
    final imagenUrl = imagenCtrl.text.trim();

    if (nombre.isEmpty || direccion.isEmpty || imagenUrl.isEmpty) {
      setState(() => mensaje = "Complete todos los campos");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('user').doc(uid).update({
        'nombre': nombre,
        'direccion': direccion,
        'imagenUrl': imagenUrl,
      });

      setState(() => mensaje = "Perfil actualizado ✔");

      // Volver a la pantalla anterior
      context.pop();

    } catch (e) {
      setState(() => mensaje = "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Editar Perfil")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(imagenCtrl.text),
              ),
              const SizedBox(height: 20),

              const Text("Nombre", style: TextStyle(fontSize: 18)),
              TextField(controller: nombreCtrl),

              const SizedBox(height: 20),
              const Text("Dirección", style: TextStyle(fontSize: 18)),
              TextField(controller: direccionCtrl),

              const SizedBox(height: 20),
              const Text("URL Imagen", style: TextStyle(fontSize: 18)),
              TextField(controller: imagenCtrl),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: guardarCambios,
                child: const Text("Guardar cambios"),
              ),

              const SizedBox(height: 20),
              Text(
                mensaje,
                style: const TextStyle(color: Colors.green),
              )
            ],
          ),
        ),
      ),
    );
  }
}