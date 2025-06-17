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
