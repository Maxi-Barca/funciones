import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/entities/funciones.dart';

final selectedFuncionProvider = StateProvider<Funcion?>((ref) => null);
final funcionesProvider = StateProvider<List<Funcion>>((ref) => funciones);