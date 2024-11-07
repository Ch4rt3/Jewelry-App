import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/direccion.dart';
import '../../../providers/direccion_provider.dart';
import 'create_address_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String? _usuarioId;

  @override
  void initState() {
    super.initState();
    _loadUsuarioId();
  }

  Future<void> _loadUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _usuarioId = prefs.getString('userId');
    });
    if (_usuarioId != null) {
      context.read<DireccionProvider>().fetchDirecciones();
    }
  }

  @override
  Widget build(BuildContext context) {
    final direcciones = Provider.of<DireccionProvider>(context).direcciones;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Direcciones'),
      ),
      body: _usuarioId == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: direcciones.length,
              itemBuilder: (context, index) {
                final direccion = direcciones[index];
                return ListTile(
                  title: Text(direccion.direccion),
                  subtitle: Text("Código Postal: ${direccion.codigoPostal}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      Provider.of<DireccionProvider>(context, listen: false)
                          .deleteDireccion(direccion.id!);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevaDireccion = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateAddressPage(usuarioId: int.parse(_usuarioId!)),
            ),
          );

          if (nuevaDireccion != null) {
            Provider.of<DireccionProvider>(context, listen: false).fetchDirecciones();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
