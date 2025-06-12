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
                  const Text(
                    'Protocolos',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
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
                            '''Esta aplicación móvil es propiedad de CDE AMISTAD. Recopilamos el correo electrónico del usuario (si lo proporciona) y gestionamos la sincronización del calendario para añadir eventos deportivos. Los datos se almacenan de forma segura y no se comparten con terceros salvo por obligación legal. Los usuarios pueden ejercer sus derechos de acceso, rectificación o cancelación escribiendo a info@cdeamistad.com.''',
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
                            '''Al utilizar esta App, acepta que CDE AMISTAD no se responsabiliza por posibles errores en la información mostrada. El usuario se compromete a un uso responsable. Todos los derechos de propiedad intelectual están reservados. Las disputas serán resueltas bajo las leyes de España y jurisdicción de Alcorcón (Madrid).''',
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
              ListTile(
                leading: Icon(Icons.article),
                title: Text('Licencias de Software'),
                onTap: () {
                  Navigator.of(context).pop();
                  Future.delayed(Duration.zero, () {
                    showLicensePage(
                      context: context,
                      applicationName: 'CDE AMISTAD',
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
        child: ListView.builder(
          itemCount: _protocolos.length,
          itemBuilder: (context, index) {
            final protocolo = _protocolos[index];
            return Card(
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
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Toca para abrir el PDF',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
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
            );
          },
        ),
      ),
    );
  }
}
