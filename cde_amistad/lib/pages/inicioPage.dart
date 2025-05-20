import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cde_amistad/entity/noticiaEntity.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cde_amistad/main.dart';
import 'package:intl/intl.dart';

class InicioPage extends StatefulWidget {
  final VoidCallback? onVerNoticias;

  const InicioPage({Key? key, this.onVerNoticias}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final _meses = {
    'enero': 1, 'febrero': 2, 'marzo': 3, 'abril': 4,
    'mayo': 5, 'junio': 6, 'julio': 7, 'agosto': 8,
    'septiembre': 9, 'octubre': 10, 'noviembre': 11, 'diciembre': 12,
  };

  Future<List<Map<String, dynamic>>> cargarNoticias() async {
    try {
      final response = await Supabase.instance.client
          .from('noticias')
          .select()
          .order('fecha', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('Error al cargar noticias: $e');
      return [];
    }
  }

  Event buildEvent(String titulo, String lugar, DateTime fecha) {
    return Event(
      title: titulo,
      description: 'Evento de CDE Amistad',
      location: lugar,
      startDate: fecha,
      endDate: fecha.add(const Duration(hours: 1)),
      iosParams: const IOSParams(reminder: Duration(minutes: 15)),
      androidParams: const AndroidParams(emailInvites: []),
    );
  }

  DateTime parseFecha(String fechaTexto) {
    try {
      final partes = fechaTexto.split(',');
      final fechaPartes = partes[0].trim().split(' ');
      final horaPartes = partes[1].trim().replaceAll('h', '').split(':');

      final dia = int.parse(fechaPartes[0]);
      final mes = _meses[fechaPartes[1].toLowerCase()] ?? 1;
      final hora = int.parse(horaPartes[0]);
      final minutos = int.parse(horaPartes[1]);

      final ahora = DateTime.now();
      return DateTime(ahora.year, mes, dia, hora, minutos);
    } catch (e) {
      debugPrint('Error parseando fecha: $e');
      return DateTime.now();
    }
  }

  Future<void> solicitarPermisoYAgregar(Event event) async {
    final status = await Permission.calendar.request();

    if (status.isGranted) {
      try {
        await Add2Calendar.addEvent2Cal(event);
        _mostrarSnackBar('Evento añadido al calendario');
      } catch (e) {
        _mostrarSnackBar('Error al añadir evento: $e');
      }
    } else {
      _mostrarSnackBar('Permiso de calendario denegado');
    }
  }

  void _mostrarSnackBar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventosMock = [
      {
        "titulo": "Partido vs Dragones",
        "fecha": "5 junio, 18:00h",
        "lugar": "Estadio Principal",
      },
      {
        "titulo": "Fiesta del Club",
        "fecha": "10 junio, 20:00h",
        "lugar": "Club Social",
      },
      {
        "titulo": "Entrenamiento Especial",
        "fecha": "12 junio, 17:00h",
        "lugar": "Campo 2",
      },
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF388E3C),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
          ),
          padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset('assets/icono.png', height: 30),
                  const SizedBox(width: 10),
                  const Text('Inicio', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white)),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: cargarNoticias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError || snapshot.data == null) return const Center(child: Text('Error al cargar noticias.'));

          final noticias = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Últimas noticias:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                ...noticias.take(3).map((noticia) {
                  final fecha = DateTime.tryParse(noticia['fecha']) ?? DateTime.now();
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NoticiaEntity(
                              titulo: noticia['titulo'],
                              contenido: noticia['contenido'],
                              imagen: noticia['imagen'],
                              fecha: fecha,
                            ),
                          ),
                        );
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          noticia['imagen'] ?? '',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 40),
                        ),
                      ),
                      title: Text(
                        noticia['titulo'] ?? 'Sin título',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            noticia['descripcion'] ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '📅 ${DateFormat('dd/MM/yyyy').format(fecha)}',
                            style: const TextStyle(fontSize: 11, color: Colors.black54, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  );
                }),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      myHomePageKey.currentState?.cambiarIndice(1);
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Ver todas las noticias'),
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Eventos próximos:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: eventosMock.length,
                    itemBuilder: (context, index) {
                      final evento = eventosMock[index];
                      final fechaEvento = parseFecha(evento['fecha']!);

                      return GestureDetector(
                        onTap: () {
                          if (fechaEvento.isBefore(DateTime.now())) {
                            _mostrarSnackBar('Este evento ya ha pasado.');
                            return;
                          }

                          final event = buildEvent(evento['titulo']!, evento['lugar']!, fechaEvento);

                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Añadir a calendario'),
                              content: Text('¿Quieres añadir "${evento['titulo']}" a tu calendario?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    await solicitarPermisoYAgregar(event);
                                  },
                                  child: const Text('Añadir'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          width: 200,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.event, size: 30, color: Colors.green),
                              const SizedBox(height: 8),
                              Text(evento['titulo']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(evento['fecha']!, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                              Text(evento['lugar']!, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                        ),
                      );
                    },
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
