import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MasPage extends StatelessWidget {
  const MasPage({Key? key}) : super(key: key);

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF388E3C),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icono.png', // Ruta de la imagen
                    height: 30,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Sobre nosotros',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  // Acción futura: mostrar notificaciones
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/icono.png'),
                  fit: BoxFit.contain,  // cambia el fit aquí
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'CDE AMISTAD',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Club Deportivo y Cultural Amistad',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            const Text(
              'Redes Sociales',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.facebook, color: Colors.blue),
              title: const Text('Facebook'),
              onTap: () => _launchURL('https://www.facebook.com/cdeamistad'),
            ),
            ListTile(
              leading: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/1200px-Instagram_logo_2016.svg.png',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
                colorBlendMode: BlendMode.srcIn, // para que el color aplique bien
              ),
              title: const Text('Instagram'),
              onTap: () => _launchURL('https://instagram.com/cdeamistad'),
            ),
            ListTile(
              leading: Image.asset(
                'assets/logo_twitter.png',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              title: const Text('X'),
              onTap: () => _launchURL('https://x.com/cdeamistad'),
            ),





            const SizedBox(height: 30),

            const Text(
              'Contacto',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.redAccent),
              title: const Text('contacto@cdeamistad.com'),
              onTap: () => _launchURL('mailto:contacto@cdeamistad.com'),
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: const Text('+34 600 123 456'),
              onTap: () => _launchURL('tel:+34600123456'),
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.red),
              title: const Text('Calle Falsa 123, Ciudad'),
              onTap: () {
                // Aquí podrías abrir Google Maps con la dirección si quieres
              },
            ),
          ],
        ),
      ),
    );
  }
}
