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
    return PetModel(
      id: doc.id,
      nombre: doc['nombre'],
      genero: doc['genero'],
      color: doc['color'],
      tipo: doc['tipo'],
      edad: doc['edad'] as int,
    );
  }
}
