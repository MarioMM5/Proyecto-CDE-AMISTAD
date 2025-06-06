import 'package:flutter/material.dart';

class NoticiaCard extends StatelessWidget {
  final String titulo;
  final String imagenUrl;
  final DateTime? fecha;
  final VoidCallback onTap;

  const NoticiaCard({
    super.key,
    required this.titulo,
    required this.imagenUrl,
    required this.fecha,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool usarImagenDefault = imagenUrl.isEmpty || !imagenUrl.startsWith('http');
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: usarImagenDefault
                    ? Image.asset(
                  'assets/imagen_default.jpg',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : Image.network(
                  imagenUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (fecha != null)
                      Text(
                        '📅 ${fecha!.day}/${fecha!.month}/${fecha!.year}',
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
