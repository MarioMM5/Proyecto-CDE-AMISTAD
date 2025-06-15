import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cde_amistad/pages/inicioPage.dart';
import 'package:cde_amistad/pages/noticiasPage.dart';
import 'package:cde_amistad/pages/tiendaPage.dart';
import 'package:cde_amistad/pages/protocolosPage.dart';
import 'package:cde_amistad/pages/masPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<_MyHomePageState> myHomePageKey = GlobalKey<_MyHomePageState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  await Supabase.initialize(
    url: 'https://sbbddlhuflacpqnrvpyb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNiYmRkbGh1ZmxhY3BxbnJ2cHliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYxMjUxNzAsImV4cCI6MjA2MTcwMTE3MH0.ZGvT8pasYJoW-2nLfoRyH5gqCsy9c218Cqkoz0XUxtU',
  );
  runApp(MyApp(isDarkMode: isDarkMode));
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
          selectedItemColor: Colors.green.shade900,
          unselectedItemColor: Colors.green.shade600,
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
      NoticiasPage(onToggleTheme: widget.onToggleTheme),
      TiendaPage(onToggleTheme: widget.onToggleTheme),
      ProtocolosPage(onToggleTheme: widget.onToggleTheme),
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
        onTap: cambiarIndice,
        type: BottomNavigationBarType.fixed,
        backgroundColor: bottomNavTheme.backgroundColor,
        selectedItemColor: bottomNavTheme.selectedItemColor,
        unselectedItemColor: bottomNavTheme.unselectedItemColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Noticias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Tienda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: 'Protocolos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
