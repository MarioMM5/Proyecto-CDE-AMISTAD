import 'package:flutter/material.dart';

class NoticiaEntity extends StatefulWidget {
  final String titulo;
  final String contenido;
  final String imagen;
  final DateTime fecha;
  final VoidCallback? onToggleTheme;

  const NoticiaEntity({
    Key? key,
    required this.titulo,
    required this.contenido,
    required this.imagen,
    required this.fecha,
    this.onToggleTheme,
  }) : super(key: key);

  @override
  State<NoticiaEntity> createState() => _NoticiaEntityState();
}

class _NoticiaEntityState extends State<NoticiaEntity> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          padding: const EdgeInsets.only(top: 45, left: 10, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BackButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      widget.titulo,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
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
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('Política de Privacidad'),
                onTap: () {
                  Navigator.of(context).pop();
                  Future.delayed(Duration.zero, () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Política de Privacidad'),
                        content: const SingleChildScrollView(
                          child: Text(
                            '''Esta aplicación móvil es propiedad de CDE AMISTAD. Recopilamos el correo electrónico del usuario (si lo proporciona) y gestionamos la sincronización del calendario para añadir eventos deportivos. Los datos se almacenan de forma segura y no se comparten con terceros salvo por obligación legal. Los usuarios pueden ejercer sus derechos de acceso, rectificación o cancelación escribiendo a info@cdeamistad.com.''',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cerrar'),
                          ),
                        ],
                      ),
                    );
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Términos y Condiciones'),
                onTap: () {
                  Navigator.of(context).pop();
                  Future.delayed(Duration.zero, () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Términos y Condiciones'),
                        content: const SingleChildScrollView(
                          child: Text(
                            '''Al utilizar esta App, acepta que CDE AMISTAD no se responsabiliza por posibles errores en la información mostrada. El usuario se compromete a un uso responsable. Todos los derechos de propiedad intelectual están reservados. Las disputas serán resueltas bajo las leyes de España y jurisdicción de Alcorcón (Madrid).''',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cerrar'),
                          ),
                        ],
                      ),
                    );
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.article),
                title: const Text('Licencias de Software'),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.imagen,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.contenido,
                style: const TextStyle(fontSize: 18, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
