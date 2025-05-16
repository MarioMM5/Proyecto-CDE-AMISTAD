import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cde_amistad/widget/noticia_card.dart';
import 'package:cde_amistad/widget/noticias_detail.dart';

class NoticiasPage extends StatelessWidget {
  const NoticiasPage({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchNoticias() async {
    final response = await Supabase.instance.client
        .from('noticias')
        .select()
        .order('fecha', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

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
                    'assets/icono.png', // Ruta de la imagen
                    height: 30,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Noticias',
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchNoticias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error al cargar noticias"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No hay noticias disponibles"));
          }

          final noticias = snapshot.data!;

          return ListView.builder(
            itemCount: noticias.length,
            itemBuilder: (context, index) {
              final noticia = noticias[index];
              final fecha = DateTime.parse(noticia['fecha']);

              return NoticiaCard(
                titulo: noticia['titulo'],
                // Quitar descripcion porque no existe:
                // descripcion: noticia['descripcion'],
                imagenUrl: noticia['imagen'],
                fecha: fecha,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoticiaDetail(
                        titulo: noticia['titulo'],
                        contenido: noticia['contenido'],
                        imagen: noticia['imagen'],
                        fecha: fecha,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
