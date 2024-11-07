import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jewelry_app/providers/user_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isEditingName = false;
  bool _isEditingEmail = false;
  bool _isEditingPassword = false;
  bool _isPasswordVisible = false;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _nameController = TextEditingController(text: userProvider.usuario?.nombre ?? '');
    _emailController = TextEditingController(text: userProvider.usuario?.email ?? '');
    _passwordController = TextEditingController(text: userProvider.usuario?.contrasena ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Llamar al método de actualización en UserProvider
                await userProvider.actualizarUsuario(
                  _nameController.text,
                  _emailController.text,
                  _passwordController.text,
                );

                // Mostrar un mensaje de éxito
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Información actualizada')),
                );
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
