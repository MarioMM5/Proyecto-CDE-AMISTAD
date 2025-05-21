import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cde_amistad/entity/noticiaEntity.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cde_amistad/main.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class InicioPage extends StatefulWidget {
  final VoidCallback? onVerNoticias;

  const InicioPage({Key? key, this.onVerNoticias}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final Map<DateTime, List<Map<String, String>>> _eventosPorDia = {};
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _inicializarEventos();
  }

  void _inicializarEventos() {
    final mockEventos = [
      {
        "titulo": "Partido vs Dragones",
        "fecha": "2025-06-05 18:00:00",
        "lugar": "Estadio Principal",
      },
      {
        "titulo": "Fiesta del Club",
        "fecha": "2025-06-10 20:00:00",
        "lugar": "Club Social",
      },
      {
        "titulo": "Entrenamiento Especial",
        "fecha": "2025-06-10 17:00:00",
        "lugar": "Campo 2",
      },
    ];

    for (final evento in mockEventos) {
      final fecha = DateTime.parse(evento['fecha']!);
      final key = DateTime(fecha.year, fecha.month, fecha.day);

      if (_eventosPorDia[key] == null) {
        _eventosPorDia[key] = [];
      }
      _eventosPorDia[key]!.add(evento);
    }
  }

  List<Map<String, String>> _obtenerEventosDelDia(DateTime day) {
    return _eventosPorDia[DateTime(day.year, day.month, day.day)] ?? [];
  }

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

  void _mostrarEventosDelDia(DateTime dia) {
    final eventos = _obtenerEventosDelDia(dia);

    if (eventos.isEmpty) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Eventos del ${DateFormat('dd/MM/yyyy').format(dia)}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: eventos.map((evento) {
            final fechaEvento = DateTime.parse(evento['fecha']!);
            final event = buildEvent(evento['titulo']!, evento['lugar']!, fechaEvento);
            return ListTile(
              title: Text(evento['titulo']!),
              subtitle: Text('${evento['lugar']} - ${DateFormat.Hm().format(fechaEvento)}'),
              trailing: IconButton(
                icon: const Icon(Icons.event_available),
                onPressed: () async {
                  await solicitarPermisoYAgregar(event);
                  Navigator.pop(context);
                },
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                const Text('Calendario de eventos:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: _obtenerEventosDelDia,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    _mostrarEventosDelDia(selectedDay);
                  },
                  calendarStyle: const CalendarStyle(
                    markerDecoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          bottom: 1,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return null;
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
