import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/entities/funciones.dart';

final funcionesProvider =
    StateNotifierProvider<FuncionesNotifier, List<Funcion>>(
  (ref) => FuncionesNotifier(FirebaseFirestore.instance),
);

class FuncionesNotifier extends StateNotifier<List<Funcion>> {
  final FirebaseFirestore db;

  FuncionesNotifier(this.db) : super([]);

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  Future<void> addFuncion(Funcion funcion) async {
    final doc = db
        .collection('user')
        .doc(uid)
        .collection('funciones')
        .doc();

    await doc.set(funcion.toFirestore());

    state = [...state, funcion.copyWith(id: doc.id)];
  }

  Future<void> getAllFunciones() async {
    final docs = await db
        .collection('user')
        .doc(uid)
        .collection('funciones')
        .withConverter(
          fromFirestore: Funcion.fromFirestore,
          toFirestore: (Funcion f, _) => f.toFirestore(),
        )
        .get();

    state = docs.docs.map((d) => d.data()).toList();
  }

  Future<void> editarFuncion(Funcion funcion) async {
    if (funcion.id == null) return;

    await db
        .collection('user')
        .doc(uid)
        .collection('funciones')
        .doc(funcion.id)
        .set(funcion.toFirestore());

    state = [
      for (final f in state)
        if (f.id == funcion.id) funcion else f,
    ];
  }

  Future<void> borrarFuncion(String id) async {
    await db
        .collection('user')
        .doc(uid)
        .collection('funciones')
        .doc(id)
        .delete();

    state = state.where((f) => f.id != id).toList();
  }
}