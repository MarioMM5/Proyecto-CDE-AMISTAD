import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cde_amistad/pages/inicioPage.dart';
import 'package:cde_amistad/pages/noticiasPage.dart';
import 'package:cde_amistad/pages/tiendaPage.dart';
import 'package:cde_amistad/pages/protocolosPage.dart';
import 'package:cde_amistad/pages/masPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:video_player/video_player.dart';


final GlobalKey<_MyHomePageState> myHomePageKey = GlobalKey<_MyHomePageState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BootApp());
}

class BootApp extends StatelessWidget {
  const BootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashLoader(),
    );
  }
}

class SplashLoader extends StatefulWidget {
  const SplashLoader({super.key});

  @override
  State<SplashLoader> createState() => _SplashLoaderState();
}

// ... tu código original hasta _SplashLoaderState

class _SplashLoaderState extends State<SplashLoader> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode = prefs.getBool('isDarkMode') ?? false;

    await Supabase.initialize(
      url: 'https://sbbddlhuflacpqnrvpyb.supabase.co',
      anonKey:
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNiYmRkbGh1ZmxhY3BxbnJ2cHliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYxMjUxNzAsImV4cCI6MjA2MTcwMTE3MH0.ZGvT8pasYJoW-2nLfoRyH5gqCsy9c218Cqkoz0XUxtU',
    );

    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      // Aquí en lugar de ir directamente a MyApp, vamos a la página del video
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SplashVideoPage(isDarkMode: isDarkMode),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}


// NUEVA PÁGINA PARA EL VIDEO SPLASH
class SplashVideoPage extends StatefulWidget {
  final bool isDarkMode;
  const SplashVideoPage({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<SplashVideoPage> createState() => _SplashVideoPageState();
}

class _SplashVideoPageState extends State<SplashVideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/videos/splash.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration &&
          !_controller.value.isPlaying) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MyApp(isDarkMode: widget.isDarkMode),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos fondo negro para evitar bordes visibles
      backgroundColor: Colors.black,
      body: _controller.value.isInitialized
          ? SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,  // Esto hace que el video rellene toda la pantalla cortando si es necesario
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: VideoPlayer(_controller),
          ),
        ),
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;
  const MyApp({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void toggleTheme() async {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CDE AMISTAD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.light),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.green.shade100,
          selectedItemColor: Colors.green.shade50,
          unselectedItemColor: Colors.green.shade200,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.green.shade900,
          selectedItemColor: Colors.green.shade50,
          unselectedItemColor: Colors.green.shade200,
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''), // Español
      ],
      locale: const Locale('es', ''),
      home: MyHomePage(
        key: myHomePageKey,
        title: 'CDE AMISTAD',
        onToggleTheme: toggleTheme,
      ),
      routes: {
        '/noticias': (context) => const NoticiasPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final VoidCallback onToggleTheme;

  const MyHomePage({Key? key, required this.title, required this.onToggleTheme})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _indiceActual = 0;

  late final List<Widget> _paginas;

  @override
  void initState() {
    super.initState();

    _paginas = [
      InicioPage(onToggleTheme: widget.onToggleTheme),
      ProtocolosPage(onToggleTheme: widget.onToggleTheme),
      NoticiasPage(onToggleTheme: widget.onToggleTheme),
      TiendaPage(onToggleTheme: widget.onToggleTheme),
      MasPage(onToggleTheme: widget.onToggleTheme),
    ];
  }

  void cambiarIndice(int nuevoIndice) {
    setState(() {
      _indiceActual = nuevoIndice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavTheme = Theme.of(context).bottomNavigationBarTheme;

    return Scaffold(
      body: _paginas[_indiceActual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceActual,
        selectedLabelStyle: const TextStyle(fontFamily: 'arial', fontSize: 18),
        unselectedLabelStyle: const TextStyle(fontFamily: 'arial', fontSize: 16),
        onTap: cambiarIndice,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF134B18),
        selectedItemColor: bottomNavTheme.selectedItemColor,
        unselectedItemColor: bottomNavTheme.unselectedItemColor,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Noticias',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Tienda',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icono.png', height: 28, width: 28),
            label: 'Club',
          ),
        ],
      ),
    );
  }
}
