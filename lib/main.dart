import 'package:flutter/material.dart';

void main() {
  runApp(const MuseosApp());
}

class MuseosApp extends StatelessWidget {
  const MuseosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MuseosPage(),
    );
  }
}

class Museo {
  final String nombre;
  final String descripcion;
  final String imagen;
  final String coordenadas;
  final String sitioWeb;

  const Museo({
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.coordenadas,
    required this.sitioWeb,
  });
}




const List<Museo> museos = [
  Museo(
    nombre: 'Museo de Arte del Río',
    descripcion: 'Coleccion de pintura y escultura moderna, con salas dedicadas al arte dl siglo xx y e exposiciones temporales.',
    imagen: 'https://i.imgur.com/0zGJgza.jpeg',
    coordenadas: '4.5981, -74.0760',
    sitioWeb: 'https://destruida.com.com',
  ),


  Museo(
    nombre: 'Museo de Historia Natural Andina',
    descripcion: 'Especímenes de fauna, flora y geología de la región andina, organizados para consulta del público y de investigadores.',
    imagen: 'https://i.imgur.com/46buiBS.jpeg',
    coordenadas: '6.2518, -75.5636',
    sitioWeb: 'https://parchadita.com',
  ),


  Museo(
    nombre: 'Museo Arqueológico del Altiplano',
    descripcion: 'Piezas arqueológicas de cerámica, orfebrería y piedra, conservadas como patrimonio de las culturas del altiplano.',
    imagen: 'https://i.imgur.com/S02V3Zc.jpeg',
    coordenadas: '5.0703, -75.5138',
    sitioWeb: 'https://gym time.com.com',
  ),


  Museo(
    nombre: 'Casa Museo del Patrimonio Local',
    descripcion: 'Casa histórica con objetos de la vida cotidiana, documentos y fotografías de la comunidad.',
    imagen: 'https://i.imgur.com/c6PPeRx.jpeg',
    coordenadas: '3.4516, -76.5320',
    sitioWeb: 'https://crazy.museo',
  )
];



class MuseosPage extends StatelessWidget {
  const MuseosPage({super.key});

  
  static const double _espacio = 20;
  static const double _altoInfo = 210; 
  static const double _proporcionFoto = 4 / 3; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.account_balance, size: 20),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                'Sistema de Administración de Museos',
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Museos',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Inventario de museos registrados en el sistema.',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  ),
                  const SizedBox(height: 18),

                  
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                        SizedBox(width: 10),
                        Text(
                          'Buscar por nombre',
                          style: TextStyle(
                              color: Color(0xFF94A3B8), fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final anchoTarjeta =
                          (constraints.maxWidth - _espacio) / 2;
                      final altoTarjeta =
                          anchoTarjeta / _proporcionFoto + _altoInfo;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: museos.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: _espacio,
                          mainAxisSpacing: _espacio,
                          mainAxisExtent: altoTarjeta,
                        ),
                        itemBuilder: (context, i) => MuseoCard(
                          museo: museos[i],
                          proporcionFoto: _proporcionFoto,
                          altoInfo: _altoInfo,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MuseoCard extends StatelessWidget {
  final Museo museo;
  final double proporcionFoto;
  final double altoInfo;

  const MuseoCard({
    super.key,
    required this.museo,
    required this.proporcionFoto,
    required this.altoInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A0F172A),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          AspectRatio(
            aspectRatio: proporcionFoto,
            child: SizedBox(
              width: double.infinity,
              child: Image.network(
                museo.imagen,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade300,
                  child: const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),
          ),

          SizedBox(
            height: altoInfo,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    museo.nombre,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    museo.descripcion,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  const Spacer(),
                  const Divider(height: 1, color: Color(0xFFE2E8F0)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 15, color: Color(0xFF64748B)),
                      const SizedBox(width: 4),
                      Text(
                        museo.coordenadas,
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xFF334155)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Sitio web: ',
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                      ),
                      Expanded(
                        child: Text(
                          museo.sitioWeb,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF2563EB)),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.open_in_new,
                          size: 13, color: Color(0xFF2563EB)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

    
