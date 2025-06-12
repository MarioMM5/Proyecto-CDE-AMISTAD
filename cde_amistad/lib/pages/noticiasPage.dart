import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cde_amistad/widget/noticia_card.dart';
import 'package:cde_amistad/widget/noticias_detail.dart';

class NoticiasPage extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  const NoticiasPage({Key? key, this.onToggleTheme}) : super(key: key);

  @override
  State<NoticiasPage> createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final supabase = Supabase.instance.client;
  late Future<List<Map<String, dynamic>>> _noticiasFuture;

  @override
  void initState() {
    super.initState();
    _noticiasFuture = fetchNoticias();
  }

  Future<List<Map<String, dynamic>>> fetchNoticias() async {
    final response = await supabase
        .from('noticias')
        .select()
        .order('fecha', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  void _abrirAjustes() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF388E3C),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))
            ],
          ),
          padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icono.png', height: 30),
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
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: _abrirAjustes,
              ),
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Ajustes',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Cambiar tema'),
                onTap: () {
                  widget.onToggleTheme?.call();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _noticiasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar las noticias',
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                  fontSize: 16,
                ),
              ),
            );
          }

          final noticias = snapshot.data ?? [];

          if (noticias.isEmpty) {
            return Center(
              child: Text(
                'No hay noticias disponibles.',
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: noticias.length,
            itemBuilder: (context, index) {
              final noticia = noticias[index];

              final String titulo = noticia['titulo'] ?? 'Sin título';
              final String contenido = noticia['contenido'] ?? 'Sin contenido';
              final String imagen = noticia['imagen'] ?? '';
              final DateTime? fecha = noticia['fecha'] != null
                  ? DateTime.tryParse(noticia['fecha'])
                  : null;

              return NoticiaCard(
                titulo: titulo,
                imagenUrl: imagen,
                fecha: fecha,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NoticiaDetail(
                        titulo: titulo,
                        contenido: contenido,
                        imagen: imagen,
                        fecha: fecha,
                        onToggleTheme: widget.onToggleTheme,
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
