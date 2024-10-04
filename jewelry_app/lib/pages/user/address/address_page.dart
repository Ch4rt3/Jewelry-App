import 'package:flutter/material.dart';
import 'dart:convert'; // Para manejar JSON
import 'dart:io'; // Para manejar archivos
import 'package:path_provider/path_provider.dart'; // Para obtener rutas del dispositivo

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<Map<String, dynamic>> _addresses = [];
  int? _selectedAddressIndex;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/addresses.json';
    final file = File(path);

    if (file.existsSync()) {
      final jsonContent = file.readAsStringSync();
      setState(() {
        _addresses = List<Map<String, dynamic>>.from(json.decode(jsonContent));
        _selectedAddressIndex =
            _addresses.indexWhere((address) => address['isDefault'] == true);
      });
    }
  }

  Future<void> _saveAddresses() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/addresses.json';
    final file = File(path);
    file.writeAsStringSync(json.encode(_addresses));
  }

  void _toggleDefaultAddress(int index) {
    setState(() {
      for (int i = 0; i < _addresses.length; i++) {
        _addresses[i]['isDefault'] = i == index;
      }
      _selectedAddressIndex = index;
    });

    _saveAddresses(); // Guardar cambios en el archivo JSON
  }

  void _addNewAddress(Map<String, dynamic> newAddress) {
    setState(() {
      _addresses.add(newAddress);
    });
    _saveAddresses(); // Guardar nuevas direcciones en el archivo JSON
  }

  void _editAddress(int index, Map<String, dynamic> editedAddress) {
    setState(() {
      _addresses[index] = editedAddress;
    });
    _saveAddresses(); // Guardar cambios en el archivo JSON
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Addresses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _addresses.length,
                itemBuilder: (context, index) {
                  final address = _addresses[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildAddressCard(address, index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Acción para agregar una nueva dirección
          final newAddress = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateAddressPage(),
            ),
          );

          if (newAddress != null) {
            _addNewAddress(newAddress);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> address, int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _selectedAddressIndex == index,
                  onChanged: (bool? value) {
                    _toggleDefaultAddress(index);
                  },
                  activeColor: Colors.black,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        address['address'],
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    // Acción de editar dirección
                    final editedAddress = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CreateAddressPage(address: address),
                      ),
                    );

                    if (editedAddress != null) {
                      _editAddress(index, editedAddress);
                    }
                  },
                  icon: const Icon(Icons.edit, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CreateAddressPage extends StatefulWidget {
  final Map<String, dynamic>? address;

  const CreateAddressPage({this.address, super.key});

  @override
  _CreateAddressPageState createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _address;

  @override
  void initState() {
    super.initState();
    _name = widget.address?['name'] ?? '';
    _address = widget.address?['address'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.address != null ? 'Edit Address' : 'Create Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) {
                  _name = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _address,
                decoration: const InputDecoration(labelText: 'Address'),
                onSaved: (value) {
                  _address = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(
                      context,
                      {'name': _name, 'address': _address, 'isDefault': false},
                    );
                  }
                },
                child: const Text('Save Address'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}