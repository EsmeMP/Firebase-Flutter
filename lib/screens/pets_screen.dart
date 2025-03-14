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
            onPressed: null,
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
                      onTap: null,
                      trailing: IconButton(
                        onPressed: null,
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
