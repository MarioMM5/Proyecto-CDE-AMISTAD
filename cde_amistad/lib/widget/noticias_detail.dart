import 'package:flutter/material.dart';

class NoticiaDetail extends StatelessWidget {
  final String titulo;
  final String contenido;
  final String imagen;
  final DateTime? fecha;

  const NoticiaDetail({
    Key? key,
    required this.titulo,
    required this.contenido,
    required this.imagen,
    required this.fecha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool usarImagenDefault = imagen.isEmpty || imagen.startsWith('http') == false;

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: usarImagenDefault
                  ? Image.asset(
                'assets/imagen_default.jpg',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              )
                  : Image.network(
                imagen,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            Text(
              titulo,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            if (fecha != null)
              Text(
                "${fecha!.day}/${fecha!.month}/${fecha!.year}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            const SizedBox(height: 20),

            Text(
              contenido,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
