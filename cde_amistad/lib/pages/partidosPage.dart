import 'package:flutter/material.dart';

class PartidosPage extends StatelessWidget {
  final List<String> partidosMasculinos = [
    'Samuráis FC vs Tigres Rojos',
    'Guerreros del Sol vs Dragones Azules',
  ];

  final List<String> partidosFemeninos = [
    'Estrellas del Amanecer vs Panteras Negras',
    'Reinas del Shogunato vs Amazonas FC',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Masculino',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ...partidosMasculinos.map((partido) => ListTile(
          leading: Icon(Icons.sports_soccer),
          title: Text(partido),
        )),

        const SizedBox(height: 24),

        Text(
          'Femenino',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ...partidosFemeninos.map((partido) => ListTile(
          leading: Icon(Icons.sports_soccer),
          title: Text(partido),
        )),
      ],
    );
  }
}