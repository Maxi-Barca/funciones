import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String mensaje = '';
  TextEditingController textControllerEmail = TextEditingController();
  TextEditingController textControllerPassword = TextEditingController();
  TextEditingController textControllerName = TextEditingController();
  TextEditingController textControllerAddress = TextEditingController();
  TextEditingController textControllerImageUrl = TextEditingController();


  final String defaultImage =
      'https://cdn-icons-png.flaticon.com/512/149/149071.png';

Future<void> crearFuncionesIniciales(String uid) async {
  final funciones = [
    {
      'nombre': 'funcion seno',
      'descripcion':
          'La función seno de un ángulo en un triángulo rectángulo se define como la relación entre la longitud del cateto opuesto al ángulo y la longitud de la hipotenusa',
      'imagenUrl':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Sine.svg/500px-Sine.svg.png',
    },
    {
      'nombre': 'funcion cuadratica',
      'descripcion':
          'En otras palabras, un término en la ecuación tendrá un exponente a la potencia de 2. Una ecuación como f ( x ) = x 2 + 4 x − 1 sería un ejemplo de función cuadrática porque tiene x elevado a la segunda potencia como su término más alto.',
      'imagenUrl':
          'https://content.nroc.org/Algebra1/COURSE_TEXT_RESOURCE/U10_L1_T1_text_final_files_es/image007.png',
    },
    {
      'nombre': 'función homográfica',
      'descripcion':
          'Define una función homográfica como una función cuya razón es el cociente de dos polinomios de primer grado. Presenta un ejemplo de función homográfica f(x)=(6x-18)/(3x-6) y estudia sus propiedades como su dominio, raíz, corte con el eje y, asíntotas y signo.',
      'imagenUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPhnEEhE8Ys9GAVgLkAKu1TzFgpshAB_H1FQ&s',
    },
    {
      'nombre': 'funcion lineal',
      'descripcion':
          'Una función lineal es una función que representa una línea recta en el plano de coordenadas. Por ejemplo, y = 3x - 2 representa una línea recta en un plano de coordenadas',
      'imagenUrl':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/FuncionLineal03.svg/300px-FuncionLineal03.svg.png',
    },
    {
      'nombre': 'funcion exponencial',
      'descripcion':
          'Una función exponencial representa la relación entre una entrada y una salida, donde usamos multiplicaciones repetidas en un valor inicial para obtener la salida para cualquier entrada dada. Las funciones exponenciales pueden crecer o decaer muy rápidamente.',
      'imagenUrl':
          'https://content.nroc.org/DevelopmentalMath/TEXTGROUP-15-19_RESOURCE/U18_L1_T1_text_final_files_es/image001.png',
    },
    {
      'nombre': 'función logaritmica',
      'descripcion':
          'El logaritmo en base 5 de 625 es 4, ya que 625 es igual a 5 a la potencia 4: 5 x 5 x 5 x 5 = 625. Dado un número (el argumento), la función logaritmo se encarga de asignarle un exponente (la potencia) al cual otro número fijo (la base) debe elevarse para obtener el argumento.',
      'imagenUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbBdmxbmyvbh_hq4EwEw8mwBNqnxDEUx6Fxw&s',
    },
  ];

  final col = FirebaseFirestore.instance
      .collection('user')
      .doc(uid)
      .collection('funciones');

  for (final f in funciones) {
    await col.add(f);
  }
}

Future<void> registerUser(
  String email,
  String contrasena,
  String nombre,
  String direccion,
  String imageUrl,
) async {
  try {
    // Crear usuario en Auth
    UserCredential cred = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: contrasena,
    );

    String uid = cred.user!.uid;

    // Datos a guardar en Firestore
    final userData = {
      'uid': uid,
      'mail': email,
      'nombre': nombre,
      'direccion': direccion,
      'imagenUrl': imageUrl,
    };

    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .set(userData);

    await crearFuncionesIniciales(uid);

    setState(() => mensaje = 'Usuario registrado con éxito');
    context.go('/home');

  } catch (e) {
    setState(() => mensaje = 'Error al registrar usuario: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Registrar nuevo usuario',
                  style: TextStyle(fontSize: 35)),
              const SizedBox(height: 20),
              const Text('Ingrese sus datos para registrarse',
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),

              const Text('Correo electrónico:', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextField(
                controller: textControllerEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              const Text('Contraseña:', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextField(
                controller: textControllerPassword,
                obscureText: true,
              ),
              const SizedBox(height: 20),

              const Text('Nombre:', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextField(
                controller: textControllerName,
              ),
              const SizedBox(height: 20),

              const Text('Dirección:', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextField(
                controller: textControllerAddress,
              ),
              const SizedBox(height: 20),

              const Text('URL de imagen (opcional):',
                  style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              TextField(
                controller: textControllerImageUrl,
                decoration: InputDecoration(
                  hintText: defaultImage,
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  final email = textControllerEmail.text.trim();
                  final contrasena = textControllerPassword.text.trim();
                  final nombre = textControllerName.text.trim();
                  final direccion = textControllerAddress.text.trim();

                  final imageUrl = textControllerImageUrl.text.trim().isEmpty
                      ? defaultImage
                      : textControllerImageUrl.text.trim();

                  if (email.isEmpty ||
                      contrasena.isEmpty ||
                      nombre.isEmpty ||
                      direccion.isEmpty) {
                    setState(() {
                      mensaje = 'Complete los campos obligatorios';
                    });
                  } else {
                    await registerUser(
                        email, contrasena, nombre, direccion, imageUrl);
                  }
                },
                child: const Text('Registrarse'),
              ),
              const SizedBox(height: 20),
              Text(mensaje),
            ],
          ),
        ),
      ),
    );
  }
}