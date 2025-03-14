import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class PetModel {
  final String id;
  final String nombre;
  final String genero;
  final String color;
  final String tipo;
  final int edad;

  PetModel({
    required this.id,
    required this.nombre,
    required this.genero,
    required this.color,
    required this.tipo,
    required this.edad,
  });

  // convertir un petmodel a un map
  // cuando se inserta una mascota desde la app
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'genero': genero,
      'color': color,
      'tipo': tipo,
      'edad': edad,
    };
  }

  // crear un petmodel desde un documentoSnapshot
  // cuando traemos informacion de Firebase

  factory PetModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {}; // Previene nulos
    return PetModel(
      id: doc.id,
      nombre: data['nombre'] ?? 'Desconocido',
      genero: data['genero'] ?? 'Desconocido',
      color: data['color'] ?? 'Sin color', // Evita el error si no existe
      tipo: data['tipo'] ?? 'Desconocido',
      edad: (data['edad'] is int)
          ? data['edad'] as int
          : int.tryParse(data['edad'].toString()) ?? 0,
    );
  }
}
