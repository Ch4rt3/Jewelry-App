import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isEditingName = false;
  bool _isEditingEmail = false;
  bool _isEditingPassword = false;
  bool _isPasswordVisible = false; // Controlar visibilidad de la contraseña

  final TextEditingController _nameController =
      TextEditingController(text: 'Bruno Pham');
  final TextEditingController _emailController =
      TextEditingController(text: 'bruno203@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '************');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Regresar a la pantalla anterior
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Acción de más opciones
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Información personal
            _buildSectionTitle('Personal Information'),
            const SizedBox(height: 10),
            _buildEditableField(
              label: 'Name',
              controller: _nameController,
              isEditing: _isEditingName,
              onEditTap: () {
                setState(() {
                  _isEditingName = !_isEditingName;
                });
              },
            ),
            const SizedBox(height: 10),
            _buildEditableField(
              label: 'Email',
              controller: _emailController,
              isEditing: _isEditingEmail,
              onEditTap: () {
                setState(() {
                  _isEditingEmail = !_isEditingEmail;
                });
              },
            ),
            const SizedBox(height: 20),
            // Sección de contraseña
            _buildSectionTitle('Password'),
            const SizedBox(height: 10),
            _buildPasswordField(
              label: 'Password',
              controller: _passwordController,
              isEditing: _isEditingPassword,
              isPasswordVisible: _isPasswordVisible,
              onEditTap: () {
                setState(() {
                  _isEditingPassword = !_isEditingPassword;
                });
              },
              onEyeTap: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Función para mostrar el título de la sección
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    );
  }

  // Función para construir los campos de texto editables
  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEditTap,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            readOnly: !isEditing, // Cambiar entre editable o no
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: Icon(isEditing ? Icons.check : Icons.edit, color: Colors.grey),
          onPressed: onEditTap, // Alternar entre editar o guardar
        ),
      ],
    );
  }

  // Función para construir el campo de contraseña
  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required bool isPasswordVisible,
    required VoidCallback onEditTap,
    required VoidCallback onEyeTap, // Controlar visibilidad
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            readOnly: !isEditing, // Cambiar entre editable o no
            obscureText: !isPasswordVisible, // Controlar visibilidad
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: Icon(isEditing ? Icons.check : Icons.edit, color: Colors.grey),
          onPressed: onEditTap, // Alternar entre editar o guardar
        ),
        IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: onEyeTap, // Mostrar/ocultar contraseña
        ),
      ],
    );
  }
}