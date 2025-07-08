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
    final bool usarImagenDefault = widget.imagen.isEmpty || !widget.imagen.startsWith('http');
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final contentColor = isDarkMode ? Colors.white70 : Colors.black87;


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
                        fontFamily: 'arial',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: usarImagenDefault
                  ? Image.asset(
                'assets/imagen_default.jpg',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              )
                  : Image.network(
                widget.imagen,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/imagen_default.jpg',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.titulo,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'impact',
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            if (widget.fecha != null)
              Text(
                "${widget.fecha!.day}/${widget.fecha!.month}/${widget.fecha!.year}",
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
            const SizedBox(height: 20),
            Text(
              widget.contenido,
              style: TextStyle(
                fontSize: 16,
                color: contentColor,
                fontFamily: 'arial',
                height: 1.6,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
