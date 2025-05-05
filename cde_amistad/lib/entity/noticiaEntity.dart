import 'package:flutter/material.dart';

class NoticiaEntity extends StatelessWidget {
  final String titulo;
  final String contenido;
  final String imagen;
  final DateTime fecha;

  const NoticiaEntity({
    Key? key,
    required this.titulo,
    required this.contenido,
    required this.imagen,
    required this.fecha
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imagen,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                contenido,
                style: const TextStyle(fontSize: 18, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
