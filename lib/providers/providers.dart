import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/entities/funciones.dart';

final funcionesProvider =
    StateNotifierProvider<FuncionesNotifier, List<Funcion>>(
  (ref) => FuncionesNotifier(FirebaseFirestore.instance),
);

class FuncionesNotifier extends StateNotifier<List<Funcion>> {
  final FirebaseFirestore db;

  FuncionesNotifier(this.db) : super([]);

  Future<void> addFuncion(Funcion funcion) async {
    final doc = db.collection('funciones').doc();
    try {
      await doc.set(funcion.toFirestore());
      state = [...state, funcion.copyWith(id: doc.id)];
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllFunciones() async {
    final docs = db
        .collection('funciones')
        .withConverter(
          fromFirestore: Funcion.fromFirestore,
          toFirestore: (Funcion funcion, _) => funcion.toFirestore(),
        );
    final funcioness = await docs.get();
    state = funcioness.docs.map((d) => d.data()).toList();
  }

  Future<void> editarFuncion(Funcion funcion) async {
    if (funcion.id == null) return;

    try {
      await db
          .collection('funciones')
          .doc(funcion.id)
          .set(funcion.toFirestore());

      state = [
        for (final f in state)
          if (f.id == funcion.id) funcion else f,
      ];
    } catch (e) {
      print(e);
    }
  }

  /// 🔥 Nuevo método para borrar función
  Future<void> borrarFuncion(String id) async {
    try {
      await db.collection('funciones').doc(id).delete();
      state = state.where((f) => f.id != id).toList();
    } catch (e) {
      print(e);
    }
  }
}