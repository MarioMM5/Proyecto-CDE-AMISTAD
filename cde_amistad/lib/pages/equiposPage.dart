import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EquiposPage extends StatefulWidget {
  const EquiposPage({super.key});

  @override
  State<EquiposPage> createState() => _EquiposPageState();
}

class _EquiposPageState extends State<EquiposPage> {
  final supabase = Supabase.instance.client;
  Map<String, Map<String, List<String>>> equiposOrganizados = {};
  bool cargando = true;

  // Orden personalizado de categorías
  final List<String> ordenCategorias = [
    'Aficionado',
    'Juvenil',
    'Cadete',
    'Infantil',
    'Alevín',
    'Benjamín',
    'Prebenjamín',
  ];

  @override
  void initState() {
    super.initState();
    cargarEquipos();
  }

  Future<void> cargarEquipos() async {
    try {
      final response = await supabase
          .from('equipo')
          .select('categoria, genero, letra');

      print('Respuesta Supabase: $response');

      final datos = response as List<dynamic>;
      final Map<String, Map<String, List<String>>> organizados = {};

      for (var equipo in datos) {
        final categoria = equipo['categoria'] ?? '';
        final genero = equipo['genero'] ?? '';
        final letra = equipo['letra'] ?? '';

        if (categoria.isEmpty || genero.isEmpty || letra.isEmpty) continue;

        organizados.putIfAbsent(categoria, () => {});
        organizados[categoria]!.putIfAbsent(genero, () => []);
        organizados[categoria]![genero]!.add(letra);
      }

      // Ordenar las letras
      for (var generoMap in organizados.values) {
        for (var letras in generoMap.values) {
          letras.sort();
        }
      }

      setState(() {
        equiposOrganizados = organizados;
        cargando = false;
      });
    } catch (e) {
      print('Error al cargar equipos: $e');
      setState(() {
        cargando = false;
      });
    }
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
                    'Equipos',
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
      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : equiposOrganizados.isEmpty
          ? const Center(child: Text('No se encontraron equipos.'))
          : ListView(
        children: ordenCategorias
            .where((cat) => equiposOrganizados.containsKey(cat))
            .map((categoria) {
          final generos = equiposOrganizados[categoria]!;

          return ExpansionTile(
            title: Text(
              categoria,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: generos.entries.map((generoEntry) {
              final genero = generoEntry.key;
              final letras = generoEntry.value;

              return ExpansionTile(
                title: Text('$genero'),
                children: letras.map((letra) {
                  return ListTile(
                    title: Text('Equipo $letra'),
                    onTap: () {
                      // Acción al pulsar el equipo
                    },
                  );
                }).toList(),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
