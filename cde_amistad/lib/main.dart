import 'package:flutter/material.dart';
import 'package:cde_amistad/pages/partidosPage.dart';
import 'package:cde_amistad/pages/inicioPage.dart';
import 'package:cde_amistad/pages/noticiasPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://sbbddlhuflacpqnrvpyb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNiYmRkbGh1ZmxhY3BxbnJ2cHliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYxMjUxNzAsImV4cCI6MjA2MTcwMTE3MH0.ZGvT8pasYJoW-2nLfoRyH5gqCsy9c218Cqkoz0XUxtU',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CDE AMISTAD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'CDE AMISTAD'),
      routes: {
        '/noticias': (context) => const NoticiasPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _indiceActual = 0;

  final List<Widget> _paginas = [
    InicioPage(),
    NoticiasPage(),
    PartidosPage(),
    Center(child: Text('Perfil')),
  ];

  void _cambiarIndice(int nuevoIndice) {
    setState(() {
      _indiceActual = nuevoIndice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[_indiceActual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceActual,
        onTap: _cambiarIndice,
        backgroundColor: Colors.green,
        // 🎨 Aquí cambias el color de fondo
        selectedItemColor: Colors.grey,
        // Color del ítem seleccionado
        unselectedItemColor: Colors.green,
        // Color de los ítems no seleccionados
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
            icon: Icon(Icons.sports_soccer),
            label: 'Partidos',
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