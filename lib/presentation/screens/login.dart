import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/entities/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String mensaje = '';
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  Future<User?> loginUser(String email, String contrasena) async {
    final corroborar = await FirebaseFirestore.instance
        .collection('user')
        .where('mail', isEqualTo: email)
        .get();

    if (corroborar.docs.isEmpty) {
      return null;
    }

    final doc = corroborar.docs.first;
    final user = User.fromFirestore(doc);

    if (user.contrasena == contrasena) {
      return user; 
    } else {
      return User(id: user.id, email: user.email, contrasena: ''); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Iniciar sesión', style: TextStyle(fontSize: 35)),
            const SizedBox(height: 20),
            const Text('Ingrese sus datos', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            const Text('Usuario:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextField(
              controller: textController1,
            ),
            const SizedBox(height: 20),
            const Text('Contraseña:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextField(
              controller: textController2,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = textController1.text.trim();
                final contra = textController2.text.trim();

                final usuario = await loginUser(email, contra);

                if (usuario != null && usuario.contrasena.isNotEmpty) {
                  context.go('/home');
                } else if (usuario != null && usuario.contrasena.isEmpty) {
                  setState(() {
                    mensaje = 'contraseña incorrecta';
                  });
                } else {
                  setState(() {
                    mensaje = 'no se encontró un usuario con ese email';
                  });
                }
              },
              child: const Text('Iniciar sesión'),
            ),
            const SizedBox(height: 20),
            Text(mensaje),
          ],
        ),
      ),
    );
  }
}