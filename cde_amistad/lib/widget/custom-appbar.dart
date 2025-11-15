import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cde_amistad/entity/noticiaEntity.dart';
import 'package:cde_amistad/main.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final VoidCallback? onToggleTheme;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBar({
    Key? key,
    required this.titulo,
    this.onToggleTheme,
    required this.scaffoldKey,
  }) : super(key: key);

  void _abrirAjustes() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // AppBar
        Container(
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
                      titulo,
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

        // Drawer (endDrawer)
        // Nota: para que funcione, hay que usar scaffoldKey desde el Scaffold
      ],
    );
  }

  /// Método que devuelve el Drawer completo
  Drawer buildEndDrawer(BuildContext context) {
    return Drawer(
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
                Navigator.of(context).pop();
                onToggleTheme?.call();
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
                      content: SingleChildScrollView(
                        child: const Text(
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
'''                         ,
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
                      content: SingleChildScrollView(
                        child: const Text(
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
                          child: const Text('Cerrar'),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
