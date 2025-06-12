import 'package:flutter/material.dart';

class CartBadge extends StatelessWidget {
  final int itemCount;

  const CartBadge({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) return const SizedBox.shrink();

    return Positioned(
      right: -4,
      top: -4,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        constraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
        child: Center(
          child: Text(
            '$itemCount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}


// Modelo de Producto
class Producto {
  final String id;
  final String nombre;
  final String precio;
  final List<String> imagenes;
  final List<String>? tallasDisponibles;

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.imagenes,
    this.tallasDisponibles,
  });
}

// Modelo de Item en el carrito
// Modelo de Item en el carrito (INMUTABLE)
class ItemCarrito {
  final Producto producto;
  final String? talla;
  final int cantidad;

  const ItemCarrito({
    required this.producto,
    this.talla,
    this.cantidad = 1,
  });

  // Método para copiar el objeto con nueva cantidad
  ItemCarrito copyWith({int? cantidad}) {
    return ItemCarrito(
      producto: producto,
      talla: talla,
      cantidad: cantidad ?? this.cantidad,
    );
  }

  // Para poder comparar objetos iguales (opcional pero recomendable)
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemCarrito &&
        other.producto.id == producto.id &&
        other.talla == talla &&
        other.cantidad == cantidad;
  }

  @override
  int get hashCode => producto.id.hashCode ^ talla.hashCode ^ cantidad.hashCode;
}



class TiendaPage extends StatefulWidget {
  final VoidCallback? onToggleTheme;

  const TiendaPage({super.key, this.onToggleTheme});

  @override
  State<TiendaPage> createState() => _TiendaPageState();
}

class _TiendaPageState extends State<TiendaPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<ItemCarrito> _carrito = [];

  // Lista de productos
  final List<Producto> _productos = [

    Producto(
      id: '2',
      nombre: 'Conjunto entrenamiento',
      precio: '49.99€',
      imagenes: ['https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/conjunto_entero.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2Nvbmp1bnRvX2VudGVyby5qcGciLCJpYXQiOjE3NDk3NDUwNDQsImV4cCI6MTc4MTI4MTA0NH0.VmU39hweJn5rRCl5oweRTuYydTyRohf8JoWamWgdIPk'],
      tallasDisponibles: ['S', 'M', 'L'],
    ),
    Producto(
      id: '3',
      nombre: 'Medias de partido',
      precio: '15.99€',
      imagenes: ['https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/calcetines_3.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2NhbGNldGluZXNfMy5qcGciLCJpYXQiOjE3NDk3NDUwODEsImV4cCI6MTc4MTI4MTA4MX0.VzSPRDT6KoMQwEFL8R2vcnBglYNvAiHfGYws6tMondU',
      'https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/calcetines_4.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2NhbGNldGluZXNfNC5qcGciLCJpYXQiOjE3NDk3NDY3MDEsImV4cCI6MTc4MTI4MjcwMX0.MEFHHBtLNMhISvw0yf9eiOW7JI16QSDOtI3d0JVX6Ac'],
    ),
    Producto(
      id: '4',
      nombre: 'Chaqueta de chandal',
      precio: '20.00€',
      imagenes: ['https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/chandal.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2NoYW5kYWwuanBnIiwiaWF0IjoxNzQ5NzQ1MTExLCJleHAiOjE3ODEyODExMTF9.dmlKbVruybo2kyNS1Z_MwD3ddEodGbPbDmVWWNh1Kow'],
      tallasDisponibles: ['S', 'M', 'L', 'XL', 'XXL'],
    ),
    Producto(
      id: '5',
      nombre: 'Pantalon de chandal',
      precio: '20.00€',
      imagenes: ['https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/chandal_3.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2NoYW5kYWxfMy5qcGciLCJpYXQiOjE3NDk3NDUxMzYsImV4cCI6MTc4MTI4MTEzNn0.98M88yoPH4RIslav0csHC6wxdSkxOwUGLyBZIWOccyA'],
      tallasDisponibles: ['S', 'M', 'L', 'XL', 'XXL'],
    ),
    Producto(
      id: '6',
      nombre: 'Chubasquero',
      precio: '25.00€',
      imagenes: ['https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/chubasquero.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2NodWJhc3F1ZXJvLmpwZyIsImlhdCI6MTc0OTc0Njc2NywiZXhwIjoxNzgxMjgyNzY3fQ.Zkikw1GQH_kstNW3K_93izJ2qxGDiBv4co18D6ORvuE',
      'https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/chubasquero_2.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2NodWJhc3F1ZXJvXzIuanBnIiwiaWF0IjoxNzQ5NzQ2Nzg4LCJleHAiOjE3ODEyODI3ODh9.EedSq_F9xybhILWW2e7PTDDezRQyy2oQRK1OeUD5MsY',
      'https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/chubasquero_3.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2NodWJhc3F1ZXJvXzMuanBnIiwiaWF0IjoxNzQ5NzQ2ODA1LCJleHAiOjE3ODEyODI4MDV9.P6mQ8XND4k8G2rl7ZrBcjwCEPgtlHKQjg_tGyGSKaVs',
      'https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/chubasquero_4.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2NodWJhc3F1ZXJvXzQuanBnIiwiaWF0IjoxNzQ5NzQ2ODI2LCJleHAiOjE3ODEyODI4MjZ9.Y9ZylkhFWQeeRV_s7YIZuN2mqIqHG90G7l-2nn2QNEE',
      'https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/chubasquero_5.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2NodWJhc3F1ZXJvXzUuanBnIiwiaWF0IjoxNzQ5NzQ2ODM0LCJleHAiOjE3ODEyODI4MzR9.K-N2sqrF673Z8ZsIP2D-01XAefhxLX-nv6Z3CTqCmxY'],
      tallasDisponibles: ['S', 'M', 'L', 'XL', 'XXL'],
    ),
    Producto(
      id: '7',
      nombre: 'Abrigo',
      precio: '36.00€',
      imagenes: ['https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/abrigo.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2Ficmlnby5qcGciLCJpYXQiOjE3NDk3NjU0MTMsImV4cCI6MTc4MTMwMTQxM30.EvDaAxZkUkFAPw44pACcpxTVcFA6nJBB0xjINxzdNrI',
        'https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/abrigo_2.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2Ficmlnb18yLmpwZyIsImlhdCI6MTc0OTc2NTQzMywiZXhwIjoxNzgxMzAxNDMzfQ.rFHuyHuDp2-wb0y-UNzQ5_XoJWDvPizsUnOOLV4eZCc',
        'https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/abrigo_3.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2Ficmlnb18zLmpwZyIsImlhdCI6MTc0OTc2NTQ1MiwiZXhwIjoxNzgxMzAxNDUyfQ.b6Izon9QZ8GZMIB_M83mD0lLtT3rncqe0iRqoFW5tNM'],
      tallasDisponibles: ['S', 'M', 'L', 'XL', 'XXL'],
    ),
    Producto(
      id: '8',
      nombre: 'Mochila',
      precio: '30.00€',
      imagenes: ['https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/mochila.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL21vY2hpbGEuanBnIiwiaWF0IjoxNzQ5NzY1NTMyLCJleHAiOjE3ODEzMDE1MzJ9.HuZYiBRaQOHDXf7U4xRHLg-XvQ-IF_UpQg8u1hyIxzI',
        'https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/mochila_2.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL21vY2hpbGFfMi5qcGciLCJpYXQiOjE3NDk3NjU1MzksImV4cCI6MTc4MTMwMTUzOX0.xACREYWEKbad77USH7lXaV3SpGwNDmoOv6Eq46bzxuc',
        'https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/mochila_3.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL21vY2hpbGFfMy5qcGciLCJpYXQiOjE3NDk3NjU1NDYsImV4cCI6MTc4MTMwMTU0Nn0.Utvt1s2b6ge0cmZ6rMP642dSbpAYeChkqk9dhdOjets'],

    ),
    Producto(
      id: '9',
      nombre: 'Polo',
      precio: '15.00€',
      imagenes: ['https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/polo.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL3BvbG8uanBnIiwiaWF0IjoxNzQ5NzY1NjQwLCJleHAiOjE3ODEzMDE2NDB9.UIYGlzIu02TNJWnielAv3E7gekDJ8bBhgj_kmzXIBmI',
        'https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/polo_2.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL3BvbG9fMi5qcGciLCJpYXQiOjE3NDk3NjU2NTAsImV4cCI6MTc4MTMwMTY1MH0.mdu4hZt3cxMKJRBOLLGg3w1BQUsk8nfEEMyZmKMsfko'],
      tallasDisponibles: ['S', 'M', 'L', 'XL', 'XXL'],
    ),
    Producto(
      id: '10',
      nombre: 'Sudadera',
      precio: '20.00€',
      imagenes: ['https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/sudadera.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL3N1ZGFkZXJhLmpwZyIsImlhdCI6MTc0OTc2NTY1OCwiZXhwIjoxNzgxMzAxNjU4fQ.qhZs2SydtmD27v1SkxmaetvqKOTQJlBvKeeOFGTYehk',
        'https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/sudadera_2.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL3N1ZGFkZXJhXzIuanBnIiwiaWF0IjoxNzQ5NzY1NjY4LCJleHAiOjE3ODEzMDE2Njh9.4WoYpihc63qP1-VeVj2rAWru2QL3Gxc3qtCete44Hm8'],
      tallasDisponibles: ['S', 'M', 'L', 'XL', 'XXL'],
    ),
    Producto(
      id: '1',
      nombre: 'Camiseta Oficial 2025',
      precio: '39.99€',
      imagenes: ['https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/camiseta.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2NhbWlzZXRhLnBuZyIsImlhdCI6MTc0OTc0NDk2NiwiZXhwIjozMzI1NDIwODk2Nn0.vpVBDkQPcM4sweYY2mYdFrU6ZS9fiTA6bT4rPrQAAao',
        'https://sbbddlhuflacpqnrvpyb.supabase.co/storage/v1/object/sign/ropa-vieja/camiseta_2.png?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9mMzIzNjVjYi03NWRjLTRkZGEtOWViZC05YjhlNThhN2YzNmUiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJyb3BhLXZpZWphL2NhbWlzZXRhXzIucG5nIiwiaWF0IjoxNzQ5NzQ2NjYwLCJleHAiOjE3ODEyODI2NjB9.sj6Qqt9bBaSlZhIyY862n4vpnk3mLtqxBLqv7mzKcjc'],
      tallasDisponibles: ['S', 'M', 'L', 'XL'],
    ),
  ];

  void _abrirAjustes() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _abrirCarrito() {
    double _parsePrecio(String precio) {
      return double.tryParse(precio.replaceAll('€', '').replaceAll(',', '.').trim()) ?? 0.0;
    }

    // Agrupar los items iguales por producto y talla
    Map<String, ItemCarrito> carritoAgrupado = {};

    for (var item in _carrito) {
      String key = '${item.producto.id}_${item.talla ?? "no_talla"}';
      if (carritoAgrupado.containsKey(key)) {
        // Incrementamos la cantidad existente
        var existente = carritoAgrupado[key]!;
        carritoAgrupado[key] = existente.copyWith(cantidad: existente.cantidad + item.cantidad);
      } else {
        carritoAgrupado[key] = item;
      }
    }

    // Calcular total sobre el carrito agrupado
    double total = carritoAgrupado.values.fold(0.0, (sum, item) {
      return sum + _parsePrecio(item.producto.precio) * item.cantidad;
    });

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Carrito de Compras',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            if (carritoAgrupado.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('El carrito está vacío'),
              )
            else
              ...carritoAgrupado.values.map((item) {
                double precioUnitario = _parsePrecio(item.producto.precio);
                double subtotal = precioUnitario * item.cantidad;
                return ListTile(
                  leading: Image.network(item.producto.imagenes.first, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(item.producto.nombre),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.talla != null) Text('Talla: ${item.talla}'),
                      Text('Precio unitario: ${precioUnitario.toStringAsFixed(2)}€'),
                      Text('Subtotal: ${subtotal.toStringAsFixed(2)}€'),
                    ],
                  ),
                  trailing: Text('x${item.cantidad}'),
                );
              }).toList(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('${total.toStringAsFixed(2)}€', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Acción de pagar aquí
              },
              child: const Text('Pagar'),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }



  void _seleccionarProducto(Producto producto) {
    String? tallaSeleccionada;
    int currentPage = 0;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {  // renombro a setStateDialog para no confundirnos
            return AlertDialog(
              title: Text(producto.nombre),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: PageView.builder(
                        itemCount: producto.imagenes.length,
                        onPageChanged: (index) {
                          setStateDialog(() {
                            currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Image.network(producto.imagenes[index]);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(producto.imagenes.length, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPage == index ? Colors.green : Colors.grey,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    if (producto.tallasDisponibles != null)
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Selecciona talla'),
                        items: producto.tallasDisponibles!
                            .map((talla) => DropdownMenuItem(value: talla, child: Text(talla)))
                            .toList(),
                        onChanged: (value) {
                          tallaSeleccionada = value;
                        },
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  child: const Text('Añadir al carrito'),
                  onPressed: () {
                    if (producto.tallasDisponibles != null && tallaSeleccionada == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Selecciona una talla')),
                      );
                      return;
                    }
                    // Aquí hacemos el setState del TIENDA PAGE
                    this.setState(() {
                      _carrito.add(ItemCarrito(
                        producto: producto,
                        talla: tallaSeleccionada,
                      ));
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
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
                    'Tienda',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: _abrirAjustes,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        // ... tu drawer no cambia
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _productos.length,
        itemBuilder: (context, index) {
          final producto = _productos[index];
          return GestureDetector(
            onTap: () => _seleccionarProducto(producto),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        producto.imagenes[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(producto.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(producto.precio),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            onPressed: _abrirCarrito,
            backgroundColor: Colors.green,
            child: const Icon(Icons.shopping_cart),
          ),
          CartBadge(itemCount: _carrito.length),
        ],
      ),
    );
  }
}

// Vista del Carrito
class _CarritoView extends StatelessWidget {
  final List<ItemCarrito> carrito;
  final Function(ItemCarrito) onEliminar;
  final VoidCallback onPagar;

  const _CarritoView({required this.carrito, required this.onEliminar, required this.onPagar});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Tu carrito', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const Divider(),
          if (carrito.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No hay productos en el carrito'),
            )
          else
            ...carrito.map((item) {
              return ListTile(
                title: Text(item.producto.nombre),
                subtitle: item.talla != null ? Text('Talla: ${item.talla}') : null,
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => onEliminar(item),
                ),
              );
            }).toList(),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: carrito.isNotEmpty ? onPagar : null,
            child: const Text('Pagar'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
