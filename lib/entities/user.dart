import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String email;
  final String contrasena;

  User({
    this.id,
    required this.email,
    required this.contrasena,
  });

  static User fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      email: data['mail'],
      contrasena: data['contra'],
    );
  }
}
