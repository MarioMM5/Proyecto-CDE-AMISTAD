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
      'titulo': 'Protocolo COVID-19',
      'url': 'https://www.example.com/protocolo_covid19.pdf',
    },
    {
      'titulo': 'Normativa de Uso de Instalaciones',
      'url': 'https://www.example.com/normativa_instalaciones.pdf',
    },
    {
      'titulo': 'Protocolo de Actuación en Lesiones',
      'url': 'https://www.example.com/protocolo_lesiones.pdf',
    },
  ];

  Future<void> _abrirPdf(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir el PDF: $url';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Ajustes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Cambiar tema'),
                onTap: () {
                  widget.onToggleTheme?.call();
                  Navigator.of(context).pop(); // cierra el drawer
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _protocolos.length,
        itemBuilder: (context, index) {
          final protocolo = _protocolos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(protocolo['titulo']!),
              trailing: IconButton(
                icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                onPressed: () => _abrirPdf(protocolo['url']!),
              ),
            ),
          );
        },
      ),
    );
  }
}
