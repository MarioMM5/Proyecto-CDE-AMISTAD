import 'package:flutter/material.dart';

class NoticiaDetail extends StatefulWidget {
  final String titulo;
  final String contenido;
  final String imagen;
  final DateTime? fecha;
  final VoidCallback? onToggleTheme;

  const NoticiaDetail({
    Key? key,
    required this.titulo,
    required this.contenido,
    required this.imagen,
    required this.fecha,
    this.onToggleTheme,
  }) : super(key: key);

  @override
  State<NoticiaDetail> createState() => _NoticiaDetailState();
}

class _NoticiaDetailState extends State<NoticiaDetail> {
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
                    width: MediaQuery.of(context).size.width * 0.5,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Ajustes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
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
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.titulo,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
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
