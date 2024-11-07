import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/direccion.dart';
import '../../../providers/direccion_provider.dart';
import '../../../providers/pais_provider.dart';
import '../../../providers/ciudad_provider.dart';

class CreateAddressPage extends StatefulWidget {
  final int usuarioId;

  const CreateAddressPage({Key? key, required this.usuarioId}) : super(key: key);

  @override
  _CreateAddressPageState createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage> {
  final _formKey = GlobalKey<FormState>();
  String _direccion = '';
  String _codigoPostal = '';
  int? _selectedPaisId;
  int? _selectedCiudadId;

  @override
  void initState() {
    super.initState();
    // Cargar los países al iniciar la página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PaisProvider>(context, listen: false).fetchPaises();
    });
  }

  @override
  Widget build(BuildContext context) {
    final paises = Provider.of<PaisProvider>(context).paises;
    final ciudades = Provider.of<CiudadProvider>(context).ciudades;

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Dirección (Usuario ID: ${widget.usuarioId})'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Dropdown de países
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Seleccionar País'),
                value: _selectedPaisId,
                items: paises.isNotEmpty
                    ? paises.map((pais) {
                        return DropdownMenuItem<int>(
                          value: pais.id,
                          child: Text(pais.nombre),
                        );
                      }).toList()
                    : null,
                onChanged: (value) {
                  setState(() {
                    _selectedPaisId = value;
                    _selectedCiudadId = null; // Reiniciar selección de ciudad
                  });
                  if (value != null) {
                    // Cargar las ciudades para el país seleccionado
                    Provider.of<CiudadProvider>(context, listen: false)
                        .fetchCiudadesByPaisId(value);
                  }
                },
                validator: (value) =>
                    value == null ? 'Por favor seleccione un país' : null,
                hint: paises.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : const Text("Seleccione un país"),
              ),
              const SizedBox(height: 16),
              // Dropdown de ciudades
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Seleccionar Ciudad'),
                value: _selectedCiudadId,
                items: ciudades.isNotEmpty
                    ? ciudades.map((ciudad) {
                        return DropdownMenuItem<int>(
                          value: ciudad.id,
                          child: Text(ciudad.nombre),
                        );
                      }).toList()
                    : null,
                onChanged: (value) {
                  setState(() {
                    _selectedCiudadId = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Por favor seleccione una ciudad' : null,
                hint: ciudades.isEmpty
                    ? const Center(child: Text("Seleccione un país primero"))
                    : const Text("Seleccione una ciudad"),
              ),
              const SizedBox(height: 16),
              // Campo de dirección
              TextFormField(
                decoration: const InputDecoration(labelText: 'Dirección'),
                onSaved: (value) => _direccion = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Por favor ingrese una dirección' : null,
              ),
              const SizedBox(height: 16),
              // Campo de código postal
              TextFormField(
                decoration: const InputDecoration(labelText: 'Código Postal'),
                onSaved: (value) => _codigoPostal = value ?? '',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Por favor ingrese el código postal' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_selectedCiudadId != null && _selectedPaisId != null) {
                      final nuevaDireccion = Direccion(
                        usuarioId: widget.usuarioId,
                        ciudadId: _selectedCiudadId!,
                        direccion: _direccion,
                        codigoPostal: _codigoPostal,
                      );

                      Provider.of<DireccionProvider>(context, listen: false)
                          .addDireccion(nuevaDireccion);

                      Navigator.pop(context, nuevaDireccion);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Seleccione un país y una ciudad.'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Guardar Dirección'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
