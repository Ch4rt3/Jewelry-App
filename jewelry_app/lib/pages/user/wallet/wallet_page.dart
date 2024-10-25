import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';  // Para obtener el directorio de documentos
import 'package:jewelry_app/pages/user/wallet/create_wallet_page.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  List<dynamic> _wallets = [];

  @override
  void initState() {
    super.initState();
    _loadWallets();  // Cargar las billeteras al iniciar
  }

  Future<void> _loadWallets() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/wallets.json';
      final file = File(path);

      if (file.existsSync()) {
        final jsonContent = file.readAsStringSync();
        setState(() {
          _wallets = json.decode(jsonContent);  // Cargar las billeteras
        });
      } else {
        // Si el archivo no existe, inicializarlo con una lista vacía
        file.writeAsStringSync(json.encode([]));
      }
    } catch (e) {
      print('Error reading wallets: $e');
    }
  }

  // Función para eliminar una billetera
  Future<void> _deleteWallet(int index) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/wallets.json';
    final file = File(path);

    // Eliminar la billetera del listado
    setState(() {
      _wallets.removeAt(index);
    });

    // Guardar la lista actualizada en el archivo JSON
    file.writeAsStringSync(json.encode(_wallets));

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Wallet deleted successfully!'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Volver a la página anterior
          },
        ),
        title: const Text(
          'Wallet',
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
            Expanded(
              child: _wallets.isNotEmpty
                  ? ListView.builder(
                      itemCount: _wallets.length,
                      itemBuilder: (context, index) {
                        final wallet = _wallets[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _buildCard(
                            cardBrand: wallet['cardBrand'],
                            cardColor: Colors.black, // Todas las tarjetas serán de color negro
                            cardNumber: wallet['cardNumber'],
                            holderName: wallet['holderName'],
                            expiryDate: wallet['expiryDate'],
                            onDelete: () => _deleteWallet(index), // Eliminar la tarjeta
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('No wallets available.'),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateWalletPage()),
          ).then((value) => _loadWallets()); // Recargar billeteras después de agregar
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Modificar la función _buildCard para agregar el botón de eliminar
  Widget _buildCard({
    required String cardBrand,
    required Color cardColor,
    required String cardNumber,
    required String holderName,
    required String expiryDate,
    required VoidCallback onDelete, // Parámetro para la función de eliminar
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  cardBrand,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,  // Agregado para evitar el desbordamiento
                ),
              ),
              Row(
                children: [
                  Text(
                    cardNumber,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    overflow: TextOverflow.ellipsis,  // Evita que el número desborde
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: onDelete, // Eliminar tarjeta cuando se presiona
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Card Holder Name\n$holderName',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Text(
            'Expiry Date\n$expiryDate',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}