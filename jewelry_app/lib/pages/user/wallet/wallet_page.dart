import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/wallet_service.dart';
import '../../../models/tarjeta.dart';
import 'create_wallet_page.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final WalletService _walletService = WalletService();
  List<Tarjeta> _wallets = [];

  @override
  void initState() {
    super.initState();
    _loadWallets(); // Cargar las billeteras al iniciar
  }

  Future<void> _loadWallets() async {
    try {
      // Obtener el usuarioId desde SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final usuarioId = prefs.getString('userId');

      if (usuarioId == null) {
        // Manejar el caso en que el usuarioId no esté disponible
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error: Usuario no autenticado.'),
        ));
        return;
      }

      // Llamar al servicio para obtener las tarjetas del usuario
      List<Tarjeta> tarjetas = await _walletService.getWalletsByUserId(usuarioId);

      setState(() {
        _wallets = tarjetas; // Cargar las billeteras
      });
    } catch (e) {
      print('Error reading wallets: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al cargar las tarjetas: $e'),
      ));
    }
  }

  // Función para eliminar una billetera
  Future<void> _deleteWallet(int index) async {
    try {
      final tarjetaId = _wallets[index].id;
      if (tarjetaId != null) {
        await _walletService.deleteWallet(tarjetaId); // Llamada al servicio para eliminar

        setState(() {
          _wallets.removeAt(index); // Eliminar la tarjeta localmente
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Wallet deleted successfully!'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al eliminar la tarjeta: $e'),
      ));
    }
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
                            cardBrand: 'Card', // Puedes personalizar esto si tienes la información
                            cardColor: Colors.black,
                            cardNumber: wallet.numeroTarjeta,
                            holderName: wallet.nombreTitular,
                            expiryDate: wallet.expFecha,
                            onDelete: () => _deleteWallet(index),
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

  Widget _buildCard({
    required String cardBrand,
    required Color cardColor,
    required String cardNumber,
    required String holderName,
    required String expiryDate,
    required VoidCallback onDelete,
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
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Text(
                    cardNumber,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: onDelete,
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
