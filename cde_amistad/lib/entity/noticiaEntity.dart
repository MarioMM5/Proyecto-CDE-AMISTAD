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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF388E3C),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.only(top: 45, left: 10, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BackButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  // Acción futura
                },
              ),
            ],
          ),
        ),
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
