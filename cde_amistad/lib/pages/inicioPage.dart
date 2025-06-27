import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cde_amistad/entity/noticiaEntity.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cde_amistad/main.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class InicioPage extends StatefulWidget {
  final VoidCallback? onVerNoticias;
  final VoidCallback? onToggleTheme;

  const InicioPage({Key? key, this.onVerNoticias, this.onToggleTheme})
      : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _meses = {
    'enero': 1, 'febrero': 2, 'marzo': 3, 'abril': 4,
    'mayo': 5, 'junio': 6, 'julio': 7, 'agosto': 8,
    'septiembre': 9, 'octubre': 10, 'noviembre': 11, 'diciembre': 12,
  };

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Map<String, dynamic>> _eventos = [];
  final Map<String, String> enlacesFotos = {
    'Aficionado A': 'https://photos.app.goo.gl/yyyyy',
    'Aficionado B': 'https://photos.app.goo.gl/yyyyy',
    'Aficionado Fem': 'https://photos.app.goo.gl/yyyyy',
    'Juvenil A': 'https://photos.app.goo.gl/yyyyy',
    'Juvenil B': 'https://photos.app.goo.gl/yyyyy',
    'Juvenil C': 'https://photos.app.goo.gl/yyyyy',
    'Juvenil A Fem': 'https://photos.app.goo.gl/yyyyy',
    'Juvenil B Fem': 'https://photos.app.goo.gl/yyyyy',
    'Cadete A': 'https://photos.app.goo.gl/yyyyy',
    'Cadete B': 'https://photos.app.goo.gl/zzzzz',
    'Cadete C': 'https://photos.app.goo.gl/zzzzz',
    'Cadete D': 'https://photos.app.goo.gl/zzzzz',
    'Cadete A Fem': 'https://photos.app.goo.gl/yyyyy',
    'Cadete B Fem': 'https://photos.app.goo.gl/yyyyy',
    'Cadete C Fem': 'https://photos.app.goo.gl/yyyyy',
    'Infantil A': 'https://photos.app.goo.gl/zzzzz',
    'Infantil B': 'https://photos.app.goo.gl/zzzzz',
    'Infantil C': 'https://photos.app.goo.gl/zzzzz',
    'Infantil D': 'https://photos.app.goo.gl/zzzzz',
    'Infantil A Fem': 'https://photos.app.goo.gl/zzzzz',
    'Infantil B Fem': 'https://photos.app.goo.gl/zzzzz',
    'Infantil C Fem': 'https://photos.app.goo.gl/zzzzz',
    'Infantil D Fem': 'https://photos.app.goo.gl/zzzzz',
    'Infantil E Fem': 'https://photos.app.goo.gl/zzzzz',
    'Infantil F Fem': 'https://photos.app.goo.gl/zzzzz',

  };

// Esta función lanza la URL al navegador
  void _abrirEnlace(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir el enlace $url';
    }
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

  Future<void> cargarEventos() async {
    try {
      final response = await Supabase.instance.client
          .from('eventos')
          .select();
      setState(() {
        _eventos = List<Map<String, dynamic>>.from(response);
      });
    } catch (e) {
      debugPrint('Error al cargar eventos: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    cargarEventos();
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

  DateTime parsearFechaSupabase(String fechaIso) {
    try {
      return DateTime.parse(fechaIso);
    } catch (e) {
      debugPrint('Error al parsear fecha de Supabase: $e');
      return DateTime.now();
    }
  }

  Future<void> solicitarPermisoYAgregar(Event event) async {
    final status = await Permission.calendarFullAccess.request(); // revisar esto

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

  void _abrirAjustes() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  List<DateTime> obtenerFechasConEventos() {
    return _eventos.map((evento) => parsearFechaSupabase(evento['fecha']))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final fechasConEventos = obtenerFechasConEventos();

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF000000),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))
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
                  const Text('Inicio', style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
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
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Ajustes', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.brightness_6),
                title: Text('Cambiar tema'),
                onTap: () {
                  widget.onToggleTheme?.call();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('Política de Privacidad'),
                onTap: () {
                  Navigator.of(context).pop();
                  Future.delayed(Duration.zero, () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Política de Privacidad'),
                        content: SingleChildScrollView(
                          child: Text(
                              '''
Política de Privacidad
Última actualización: 17 de junio de 2025

En CDE Amistad, respetamos tu privacidad y estamos comprometidos con proteger los datos personales que puedas proporcionarnos al utilizar nuestra aplicación.

1. Información que recopilamos
- Datos de uso: Recopilamos información anónima sobre cómo utilizas la app (pantallas vistas, eventos abiertos, etc.).
- Notificaciones: Solo accedemos a datos necesarios para enviarte notificaciones relacionadas con actividades del club (si decides activarlas).
- Datos personales: En versiones futuras podríamos solicitar nombre, correo o equipo preferido para personalizar tu experiencia. Si eso sucede, se te pedirá permiso explícito.

2. Finalidad del tratamiento
Utilizamos los datos para:
- Mejorar la app y su funcionalidad.
- Enviar notificaciones de noticias, partidos, eventos y otras actividades del club.
- Garantizar el correcto funcionamiento técnico.

3. Compartición de datos
No compartimos tus datos personales con terceros, salvo obligación legal o si se trata de servicios estrictamente necesarios para el funcionamiento de la app (como servicios de análisis o notificaciones).

4. Seguridad
Implementamos medidas técnicas y organizativas para proteger tu información personal frente a accesos no autorizados o pérdida.

5. Derechos del usuario
Puedes solicitar en cualquier momento:
- Acceso a tus datos personales.
- Rectificación o eliminación.
- Limitación u oposición al tratamiento.

Para ejercer estos derechos, contacta con nosotros en: info@cdeamistad.com
'''                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cerrar'),
                          ),
                        ],
                      ),
                    );
                  });
                },
              ),
             ListTile(
                leading: Icon(Icons.description),
                title: Text('Términos y Condiciones'),
                onTap: () {
                  Navigator.of(context).pop();
                  Future.delayed(Duration.zero, () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Términos y Condiciones'),
                        content: SingleChildScrollView(
                          child: Text(
                            '''
Términos y Condiciones de Uso
Última actualización: 17 de junio de 2025

Estos Términos regulan el acceso y uso de la aplicación móvil del CDE Amistad. Al utilizar la app, aceptas cumplir estos términos.

1. Uso permitido
Esta app está diseñada para:
- Informar sobre noticias, actividades y eventos del CDE Amistad.
- Mostrar equipos, jugadores, clasificaciones y partidos.
- Facilitar la conexión entre el club y sus seguidores.

No está permitido:
- Utilizar la app para fines ilegales o comerciales no autorizados.
- Alterar o interferir con el funcionamiento de la app.

2. Propiedad intelectual
Todos los contenidos (textos, imágenes, logos, etc.) son propiedad del CDE Amistad o de sus respectivos titulares. No se permite su reproducción sin consentimiento previo.

3. Responsabilidad
La app se proporciona "tal cual". Aunque hacemos esfuerzos para mantener la información actualizada, no garantizamos la exactitud completa de todos los datos (ej. horarios de partidos o clasificaciones).

4. Modificaciones
Nos reservamos el derecho a modificar estos términos o la política de privacidad. Te notificaremos cualquier cambio relevante a través de la app.

5. Contacto
Si tienes dudas, escríbenos a: info@cdeamistad.com
''',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cerrar'),
                          ),
                        ],
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),


      body: FutureBuilder<List<Map<String, dynamic>>>(

        future: cargarNoticias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError || snapshot.data == null)
            return const Center(child: Text('Error al cargar noticias.'));

          final noticias = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Últimas noticias:', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                ...noticias.take(3).map((noticia) {
                  final fecha = DateTime.tryParse(noticia['fecha']) ??
                      DateTime.now();
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                NoticiaEntity(
                                  titulo: noticia['titulo'],
                                  contenido: noticia['contenido'],
                                  imagen: noticia['imagen'],
                                  fecha: fecha,
                                  onToggleTheme: widget.onToggleTheme,
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
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image, size: 40),
                        ),
                      ),
                      title: Text(
                        noticia['titulo'] ?? 'Sin título',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
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
                            style: const TextStyle(fontSize: 11,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12,
                          vertical: 8),
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
                const Text('Fotos:', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        height: 200, // Altura máxima del bloque
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Scrollbar(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: enlacesFotos.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 3.2,
                            ),
                            itemBuilder: (context, index) {
                              final nombreEquipo = enlacesFotos.keys.elementAt(index);
                              final url = enlacesFotos[nombreEquipo]!;
                              return ElevatedButton.icon(
                                onPressed: () => _abrirEnlace(url),
                                icon: const Icon(Icons.photo, size: 16),
                                label: Text(nombreEquipo, style: const TextStyle(fontSize: 12)),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black87,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),



                const SizedBox(height: 10),
                const Text('Eventos en el calendario:', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                TableCalendar(
                  locale: 'es_ES',
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });

                    final eventosDia = _eventos.where((evento) {
                      final fechaEvento = parsearFechaSupabase(evento['fecha']);
                      return fechaEvento.year == selectedDay.year &&
                          fechaEvento.month == selectedDay.month &&
                          fechaEvento.day == selectedDay.day;
                    }).toList();

                    if (eventosDia.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (_) =>
                            AlertDialog(
                              title: const Text('Eventos del día'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: eventosDia.map((evento) {
                                  final fechaEvento = parsearFechaSupabase(
                                      evento['fecha']);
                                  final horaFormateada = DateFormat('HH:mm')
                                      .format(fechaEvento);
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                            evento['titulo'] ?? 'Evento'),
                                        subtitle: Text(
                                            '${evento['lugar']} - $horaFormateada'),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () {
                                            final event = buildEvent(
                                              evento['titulo'] ?? 'Evento',
                                              evento['lugar'] ?? '',
                                              fechaEvento,
                                            );
                                            solicitarPermisoYAgregar(event);
                                          },
                                          child: const Text(
                                              'Añadir al calendario'),
                                        ),
                                      ),
                                    ],
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
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      final tieneEvento = fechasConEventos.any((fecha) =>
                      fecha.year == day.year && fecha.month == day.month &&
                          fecha.day == day.day);
                      if (tieneEvento) {
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
