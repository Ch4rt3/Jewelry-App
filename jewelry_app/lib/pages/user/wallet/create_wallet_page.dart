import 'package:flutter/material.dart';
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:jewelry_app/models/tarjeta.dart';
import 'package:jewelry_app/services/wallet_service.dart';
import 'package:provider/provider.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({super.key});

  @override
  _CreateWalletPageState createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {
  final _formKey = GlobalKey<FormState>();
  String _cardNumber = '';
  String _holderName = '';
  String _expiryDate = '';
  String _cvv = '';
  final WalletService _walletService = WalletService();
  String? userId;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.loadUserId(); // Cargar el ID del usuario desde SharedPreferences
    setState(() {
      userId = userProvider.userId; // Asignar el ID a la variable local
    });
  }

  // Función para guardar la billetera utilizando el usuarioId
  Future<void> _saveWallet() async {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error: Usuario no autenticado.'),
      ));
      return;
    }

    // Crear la estructura de la tarjeta con usuarioId
    Tarjeta newWallet = Tarjeta(
      usuarioId: userId!, // usuarioId como String
      numeroTarjeta: _cardNumber,
      nombreTitular: _holderName,
      expFecha: _expiryDate,
      cvv: _cvv,
    );

    try {
      // Llamar al servicio para crear la tarjeta en el backend
      final response = await _walletService.createWallet(newWallet);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Wallet created successfully!'),
        ));
        Navigator.pushReplacementNamed(context, '/wallet');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al crear la tarjeta: ${response.statusCode}'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al crear la tarjeta: $e'),
      ));
    }
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
                Text('User ID: ${userId ?? 'Cargando...'}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Card Number'),
                  onSaved: (value) => _cardNumber = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the card number';
                    }
                    return null;
                  },
                ),
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
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
                  onSaved: (value) => _expiryDate = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the expiry date';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
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
                      _saveWallet();
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
