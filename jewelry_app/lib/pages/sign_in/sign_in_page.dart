import 'package:flutter/material.dart';
import 'package:jewelry_app/configs/colors.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: AppColors.backgroundLogin,
          child: Column(
            children: [
              const SizedBox(height: 165),
              // Contenedor curvado
              Container(
                height: 600,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0), // Espaciado interior
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40), // Espaciado
                      // Título
                      const Text(
                        'Inicio de sesión',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Campo de correo electrónico
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Correo electrónico',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Campo de contraseña
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // ¿Olvidó su contraseña?
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Acción para recuperar contraseña
                          },
                          child: const Text(
                            '¿Olvidó su contraseña?',
                            style: TextStyle(color: AppColors.textColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Botón de ingresar
                      ElevatedButton(
                        onPressed: () {
                          // Acción de inicio de sesión
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.thirdColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 60,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'INGRESAR',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // ¿No tienes cuenta aún? Registrarse
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '¿No tienes una cuenta aún?',
                            style: TextStyle(color: AppColors.textColor,),
                          ),
                          TextButton(
                            onPressed: () {
                              // Acción de registrarse
                            },
                            child: const Text(
                              'Registrarse',
                              style: TextStyle(color: AppColors.textColor,),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Iniciar sesión con Google
                      IconButton(
                        onPressed: () {
                          // Acción para iniciar sesión con Google
                        },
                        icon: const Icon(
                          Icons.g_mobiledata,
                          size: 50,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: null,
        body: _buildBody(context),
      ),
    );
  }
}
