import 'package:flutter/material.dart';
import 'dart:convert'; // Para manejar JSON
import 'dart:io'; // Para manejar archivos
import 'package:path_provider/path_provider.dart'; // Para obtener rutas del dispositivo
import 'package:uuid/uuid.dart'; // Para generar un ID único

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({super.key});

  @override
  _CreateWalletPageState createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {
  final _formKey = GlobalKey<FormState>();
  String _cardBrand = '';
  String _cardNumber = '';
  String _holderName = '';
  String _expiryDate = '';
  String _cvv = '';

  // Obtener la ruta del archivo wallets.json
  Future<String> _getWalletsFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/wallets.json';
  }

  // Función para guardar la billetera
  Future<void> _saveWallet() async {
    // Generar un ID único para la nueva billetera
    var uuid = Uuid();
    String walletId = uuid.v4(); // Generar un ID único

    // Estructura de la nueva tarjeta
    Map<String, String> newWallet = {
      'id': walletId,  // Agregar ID único
      'cardBrand': _cardBrand,
      'cardNumber': _cardNumber,
      'holderName': _holderName,
      'expiryDate': _expiryDate,
      'cvv': _cvv,  // Agregar CVV
    };

    // Obtener la ruta correcta para guardar el archivo wallets.json en el dispositivo
    final path = await _getWalletsFilePath();
    final file = File(path);
    
    List<dynamic> wallets = [];

    // Si el archivo existe, cargar el contenido JSON
    if (file.existsSync()) {
      String jsonContent = file.readAsStringSync();
      wallets = json.decode(jsonContent);
    }

    // Agregar la nueva billetera a la lista
    wallets.add(newWallet);

    // Guardar la lista actualizada en el archivo JSON
    file.writeAsStringSync(json.encode(wallets));

    // Mostrar mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Wallet created successfully!'),
    ));

    // Navegar de vuelta a la pantalla de Wallet
    Navigator.pushReplacementNamed(context, '/wallet');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Wallet'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Campo para la marca de la tarjeta
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Card Brand'),
                  onSaved: (value) => _cardBrand = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the card brand';
                    }
                    return null;
                  },
                ),
                // Campo para el número de la tarjeta (teclado numérico)
                TextFormField(
                  keyboardType: TextInputType.number,  // Teclado numérico
                  decoration: const InputDecoration(labelText: 'Card Number'),
                  onSaved: (value) => _cardNumber = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the card number';
                    }
                    return null;
                  },
                ),
                // Campo para el nombre del titular de la tarjeta
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Card Holder Name'),
                  onSaved: (value) => _holderName = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the card holder name';
                    }
                    return null;
                  },
                ),
                // Campo para la fecha de vencimiento (teclado numérico)
                TextFormField(
                  keyboardType: TextInputType.datetime,  // Teclado numérico para fechas
                  decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                  onSaved: (value) => _expiryDate = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the expiry date';
                    }
                    return null;
                  },
                ),
                // Campo para el CVV (teclado numérico)
                TextFormField(
                  keyboardType: TextInputType.number,  // Teclado numérico
                  decoration: const InputDecoration(labelText: 'CVV'),
                  onSaved: (value) => _cvv = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the CVV';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _saveWallet(); // Llamar a la función para guardar y navegar
                    }
                  },
                  child: const Text('Create Wallet'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
