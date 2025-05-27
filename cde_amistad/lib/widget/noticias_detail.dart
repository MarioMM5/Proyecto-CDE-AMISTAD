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
    final bool usarImagenDefault = imagen.isEmpty || !imagen.startsWith('http');

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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
