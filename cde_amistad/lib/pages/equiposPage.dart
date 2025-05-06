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
      appBar: AppBar(title: const Text('Equipos')),
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
                title: Text('Género: $genero'),
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
