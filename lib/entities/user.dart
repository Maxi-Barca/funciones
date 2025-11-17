import 'package:cloud_firestore/cloud_firestore.dart';

class UserCustom {
  final String id;          // UID de FirebaseAuth
  final String email;       // mail
  final String nombre;      // nombre del usuario
  final String direccion;   // dirección
  final String imagenUrl;   // URL de la imagen del usuario

  UserCustom({
    required this.id,
    required this.email,
    required this.nombre,
    required this.direccion,
    required this.imagenUrl,
  });

  factory UserCustom.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserCustom(
      id: data['uid'] ?? '',
      email: data['mail'] ?? '',
      nombre: data['nombre'] ?? '',
      direccion: data['direccion'] ?? '',
      imagenUrl: data['imagenUrl'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': id,
      'mail': email,
      'nombre': nombre,
      'direccion': direccion,
      'imagenUrl': imagenUrl,
    };
  }

  UserCustom copyWith({
    String? id,
    String? email,
    String? nombre,
    String? direccion,
    String? imagenUrl,
  }) {
    return UserCustom(
      id: id ?? this.id,
      email: email ?? this.email,
      nombre: nombre ?? this.nombre,
      direccion: direccion ?? this.direccion,
      imagenUrl: imagenUrl ?? this.imagenUrl,
    );
  }
}