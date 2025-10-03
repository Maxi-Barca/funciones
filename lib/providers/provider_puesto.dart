import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/entities/funciones.dart';

final selectedFuncionIndexProvider = StateProvider<int>((ref) => 0);
final selectedFuncionProvider = StateProvider<Funcion?>((ref) => null);