import 'package:fire_crud_5a25/auth_service.dart';
import 'package:fire_crud_5a25/screens/pets_screen.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido a la aplicación de mascotas'),
            ElevatedButton.icon(
              onPressed: () async {
                final credenciales = await _authService.signInWithGoogle();
                print('Usuario: ${credenciales.user?.displayName}');
                print('Usuario: ${credenciales.user?.email}');
                // si todo sale bien, navegar a la pantalla de mascotas
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PetsScreen()));
              },
              icon: const Icon(Icons.login),
              label: const Text(
                'Iniciar sesion con Google',
              ),
            )
          ],
        ),
      ),
    );
  }
}
