import 'package:fire_crud_5a25/models/pet_model.dart';
import 'package:fire_crud_5a25/services/firestore_service.dart';
import 'package:flutter/material.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
// Declarar los controladores para las cajas de texto
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _generoController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();

  void _deletePet(String docId) {
    _firestoreService.deletePet('mascotas', docId);
  }

  void _addPet() {
    _firestoreService.addPet('mascotas', {
      'nombre': _nombreController.text,
      'tipo': _tipoController.text,
      'color': _colorController.text,
      'genero': _generoController.text,
      'edad': int.parse(_edadController.text),
    });

    _nombreController.clear();
    _tipoController.clear();
    _colorController.clear();
    _generoController.clear();
    _edadController.clear();
  }

  void _updatePet(
    String docId,
    TextEditingController nombreController,
    TextEditingController tipoController,
    TextEditingController colorController,
    TextEditingController generoController,
    TextEditingController edadController,
  ) {
    if (edadController.text.isEmpty ||
        int.tryParse(edadController.text) == null) {
      // print("Error: Edad inválida");
      return;
    }

    _firestoreService.updatePet('mascotas', docId, {
      'nombre': nombreController.text,
      'tipo': tipoController.text,
      'color': colorController.text,
      'genero': generoController.text,
      'edad': int.parse(edadController.text),
    });

    Navigator.of(context).pop(); // Cierra el diálogo después de actualizar
  }

  void _showUpdateDialog(PetModel pet) {
    TextEditingController nombreController = TextEditingController();
    TextEditingController tipoController = TextEditingController();
    TextEditingController colorController = TextEditingController();
    TextEditingController generoController = TextEditingController();
    TextEditingController edadController = TextEditingController();
    nombreController.text = pet.nombre;
    tipoController.text = pet.tipo;
    colorController.text = pet.color;
    generoController.text = pet.genero;
    edadController.text = pet.edad.toString();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Actualizar mascota'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                TextField(
                  controller: tipoController,
                  decoration: const InputDecoration(
                    labelText: 'Tipo',
                  ),
                ),
                TextField(
                  controller: colorController,
                  decoration: const InputDecoration(
                    labelText: 'Color',
                  ),
                ),
                TextField(
                  controller: generoController,
                  decoration: const InputDecoration(
                    labelText: 'Genero',
                  ),
                ),
                TextField(
                  controller: edadController,
                  decoration: const InputDecoration(
                    labelText: 'Edad',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    _updatePet(pet.id, nombreController, tipoController,
                        colorController, generoController, edadController);
                    // Navigator.of(context).pop();
                  },
                  child: Text('Actualizar')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masacotas - en Firebase'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          TextField(
            controller: _generoController,
            decoration: const InputDecoration(labelText: 'Genero'),
          ),
          TextField(
            controller: _colorController,
            decoration: const InputDecoration(labelText: 'Color'),
          ),
          TextField(
            controller: _tipoController,
            decoration: const InputDecoration(labelText: 'Tipo'),
          ),
          TextField(
            controller: _edadController,
            decoration: const InputDecoration(labelText: 'Edad'),
          ),
          ElevatedButton(
            onPressed: _addPet,
            child: const Text('Agregar mascota'),
          ),
          // Aqui se muestra las mascotas
          Expanded(
            child: StreamBuilder(
              stream: _firestoreService.getPets('mascotas'),
              builder: (context, AsyncSnapshot<List<PetModel>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  children: snapshot.data!.map((PetModel pet) {
                    return ListTile(
                      title: Text(pet.nombre),
                      subtitle: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(pet.tipo),
                          Text(pet.color),
                          Text(pet.genero),
                          Text(pet.edad.toString()),
                        ],
                      ),
                      onTap: () => _showUpdateDialog(pet),
                      trailing: IconButton(
                        onPressed: () => _deletePet(pet.id),
                        icon: Icon(Icons.delete),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
