import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProtocolosPage extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  const ProtocolosPage({super.key, this.onToggleTheme});

  @override
  State<ProtocolosPage> createState() => _ProtocolosPageState();
}

class _ProtocolosPageState extends State<ProtocolosPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, String>> _protocolos = const [
    {
      'titulo': 'Protocolo de Actuación en Lesiones',
      'url': 'https://rffm-cms.s3.eu-west-1.amazonaws.com/MADRID_PROTOCOLO_DE_ACTUACION_2024_2025_72bf3065bc.pdf',
    },
    {
      'titulo': 'Guía LOVIPI para padres y madres',
      'url': 'https://rffm-cms.s3.eu-west-1.amazonaws.com/GUIA_LOPIVI_PROGENITORES_0578a966b3.pdf',
    },
    {
      'titulo': 'Protocolo de actuación LOVIPI',
      'url': 'https://rffm-cms.s3.eu-west-1.amazonaws.com/Protocolo_de_actuacion_de_la_RFFM_para_la_proteccion_integral_a_infancia_y_adolescencia_frente_a_la_violencia_LOPIVI_148c5a1eba.pdf',
    },
  ];

  Future<void> _abrirPdf(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir el PDF')),
      );
    }
  }

  void _abrirAjustes() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF000000),
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
                  const Text(
                    'Protocolos',
                    style: TextStyle(fontSize: 24,
                        fontFamily: 'impact',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
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
                    fontSize: 20,

                    fontWeight: FontWeight.bold)),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: ListView(
          children: [

            // Pretemporada
            const Text('🏕️ Pretemporada', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('La pretemporada comenzará el ...', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text('• Inicio: 12 de agosto'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Horarios
            const Text('🕓 Horarios', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Los entrenamientos se realizarán en:', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Precios
            const Text('💰 Precios', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Cuotas para la temporada 2025/2026:', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Documentación + Protocolos
            const Text('📄 Documentación', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Para comenzar la temporada, se necesita:', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text('• Fotocopia del DNI o libro de familia'),
                    Text('• Reconocimiento médico reciente'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),
            const Text('📘 Protocolos', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            // Aquí mantenemos tu lista de protocolos
            ..._protocolos.map((protocolo) => Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _abrirPdf(protocolo['url']!),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      const Icon(Icons.description_outlined, size: 36, color: Colors.green),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              protocolo['titulo']!,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Toca para abrir el PDF',
                              style: TextStyle(fontSize: 13, color: Colors.grey[600], fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withAlpha((0.1 * 255).round()),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 30),
                          onPressed: () => _abrirPdf(protocolo['url']!),
                          tooltip: 'Abrir PDF',
                          splashRadius: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),

            const SizedBox(height: 20),

            // Actividades
            const Text('⚽ Actividades', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Durante el año realizaremos:', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text('• Fiesta de fin de temporada con medallas'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
