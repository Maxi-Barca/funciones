import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/entities/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Credenciales válidas

  // Texto ingresado por el usuario
  String inputUsuario = '';
  String inputContrasena = '';
  String mensaje = '';

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Iniciar sesión', style: TextStyle(fontSize: 35)),
            const SizedBox(height: 20),
            Text('Ingrese sus datos', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text('Usuario:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextField(
              //que se ingrese el usuario
              controller: textController1,
            ),
            const SizedBox(height: 20),
            Text('Contraseña:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            TextField(
              //que se ingrese la constraseña
              controller: textController2,
              obscureText: true, // Oculta el texto con puntos
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  inputUsuario = textController1.text;
                  inputContrasena = textController2.text;

                  User? usuarioEncontrado;

                  for (User usuario in usuarios) {
                    if (usuario.email == inputUsuario) {
                      usuarioEncontrado = usuario;
                      break;
                    }
                  }

                  if (usuarioEncontrado != null) {
                    if (usuarioEncontrado.contrasena == inputContrasena) {
                      context.go('/home', extra: usuarioEncontrado);
                    } else {
                      mensaje = 'Contraseña incorrecta';
                    }
                  } else {
                    mensaje = 'No se encontró un usuario con ese email';
                  }
                });
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
