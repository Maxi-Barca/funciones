import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<UserCustom?> loginUser(String email, String contrasena) async {
    try {
      UserCredential cred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: contrasena);

      final uid = cred.user!.uid;

      final doc = await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .get();

      if (!doc.exists) return null;

      return UserCustom.fromFirestore(doc);

    } catch (e) {
      mensaje = "Error al iniciar sesión: $e";
      return null;
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

                if (email.isEmpty || contra.isEmpty) {
                  setState(() {
                    mensaje = "Complete ambos campos";
                  });
                  return;
                }

                final usuario = await loginUser(email, contra);

                if (usuario != null) {
                  context.go('/home');
                } else {
                  setState(() {
                    mensaje = 'Usuario o contraseña incorrectos';
                  });
                }
              },
              child: const Text('Iniciar sesión'),
            ),

            const SizedBox(height: 20),
            Text(mensaje),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                context.go('/register');
              },
              child: const Text(
                'Registrate si no tenes cuenta',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}