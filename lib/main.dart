import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/create_visitor.dart';
import 'screens/visitor_list.dart';
import 'screens/edit_visitor.dart';

void main() {
  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/create',
        builder: (context, state) => const CreateVisitorScreen(),
      ),
      GoRoute(
        path: '/list',
        builder: (context, state) => const VisitorListScreen(),
      ),
      GoRoute(
        path: '/edit/:id',
        builder: (context, state) {
          // Acceso actualizado a los parámetros de la ruta
          final visitorId = state.pathParameters['id']!;
          return EditVisitorScreen(visitorId: visitorId);
        },
      ),
    ],
  );

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'CRUD UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
