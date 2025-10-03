import 'package:cloud_firestore/cloud_firestore.dart';

class Funcion {
  final String? id;
  final String funcion;
  final String descripcion;
  final String imagenUrl;

  Funcion({
    this.id,
    required this.funcion,
    required this.descripcion,
    required this.imagenUrl,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'nombre': funcion,
      'descripcion': descripcion,
      'imagenUrl': imagenUrl,
    };
  }

  static Funcion fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Funcion(
      id: snapshot.id,
      funcion: data?['nombre'],
      descripcion: data?['descripcion'],
      imagenUrl: data?['imagenUrl'],
    );
  }
    Funcion copyWith({
    String? id,
    String? funcion,
    String? descripcion,
    String? imagenUrl,
  }) {
    return Funcion(
      id: id ?? this.id,
      funcion: funcion ?? this.funcion,
      descripcion: descripcion ?? this.descripcion,
      imagenUrl: imagenUrl ?? this.imagenUrl,
    );
  }
}
