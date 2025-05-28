import 'package:flutter/material.dart';

class TiendaPage extends StatelessWidget {
  const TiendaPage({super.key});

  // Lista simulada de productos
  final List<Map<String, String>> _productos = const [
    {
      'nombre': 'Camiseta Oficial 2025',
      'precio': '29.99€',
      'imagen': 'https://via.placeholder.com/150x150.png?text=Camiseta',
    },
    {
      'nombre': 'Pantalón Entrenamiento',
      'precio': '19.99€',
      'imagen': 'https://via.placeholder.com/150x150.png?text=Pantalón',
    },
    {
      'nombre': 'Medias Verdes',
      'precio': '7.99€',
      'imagen': 'https://via.placeholder.com/150x150.png?text=Medias',
    },
    {
      'nombre': 'Chándal Completo',
      'precio': '49.99€',
      'imagen': 'https://via.placeholder.com/150x150.png?text=Chandal',
    },
  ];

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
          padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icono.png',
                    height: 30,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Tienda',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  // Acción futura: mostrar notificaciones
                },
              ),
            ],
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _productos.length,
        itemBuilder: (context, index) {
          final producto = _productos[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      producto['imagen']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(producto['nombre']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(producto['precio']!),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Ver más sobre "${producto['nombre']}"')),
                          );
                        },
                        child: const Text('Ver'),
                        style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(36)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
