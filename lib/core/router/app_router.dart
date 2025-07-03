import 'package:go_router/go_router.dart';
import 'package:myapp/presentation/screens/agregar.dart';
import 'package:myapp/presentation/screens/decripciones.dart';
import 'package:myapp/presentation/screens/edit.dart';
import 'package:myapp/presentation/screens/home.dart';
import 'package:myapp/presentation/screens/login.dart';



final appRouter = GoRouter(
  initialLocation:'/login',
  routes: [
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/detail',
    builder: (context, state) => const DetailScreen(),
  ),
  GoRoute(
    path: '/agregar',
    builder: (context, state) => const AgregarScreen(),
  ),
  GoRoute(
    path: '/edit',
    builder: (context, state) => const EditScreen(),
  ),
]);