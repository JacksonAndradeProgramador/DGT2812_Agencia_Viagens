import 'dart:async'; 
import 'package:flutter/material.dart'; 

void main() {
  runApp(const MyApp());
}

/// =====================
/// APP RAIZ
/// =====================
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explore Mundo',
      home: HomePage(),
    );
  }
}

/// =====================
/// HOME PAGE
/// =====================


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;  // Controla o PageView (slideshow)

  final ScrollController _destinosScrollController = ScrollController();  // Controla o scroll horizontal dos cards

  int _currentPage = 0; // Guarda qual slide está ativo

  // DADOS   
  final List<Map<String, String>> destinos = [
    {
      'image': 'assets/images/paris.webp',
      'title': 'Paris',
      'rating': '4.9',
      'local': 'França',
    },
    {
      'image': 'assets/images/roma.webp',
      'title': 'Roma',
      'rating': '4.8',
      'local': 'Itália',
    },
    {
      'image': 'assets/images/newyork.jpg',
      'title': 'Nova York',
      'rating': '4.7',
      'local': 'EUA',
    },
  ];

  //(SLIDESHOW AUTOMÁTICO)
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
 
    Timer.periodic(const Duration(seconds: 3), (timer) {  //Executa a cada 3 segundos
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % destinos.length; //Avança slide e % garante looping infinito

      //Anima a troca de slide suavemente
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
    //Libera memória, Evita vazamento (memory leak)
  void dispose() { 
    _pageController.dispose();
    _destinosScrollController.dispose();
    
    super.dispose();
  }



  /// =====================
  /// BOTÃO REUTILIZÁVEL
  /// =====================
  /// Permite clique + efeito visual
  Widget _buildButtonColumn(
    Color color,
    IconData icon,
    String label, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// =====================
  /// SLIDESHOW (BANNER)
  /// =====================
  Widget bannerSection(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        controller: _pageController, //Conecta com o slideshow automático
        itemCount: destinos.length,

        //tualiza: avaliação e estado da tela
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          //clica no slide, abre DestinoPage
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      DestinoPage(destino: destinos[index]),
                ),
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  destinos[index]['image']!,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    destinos[index]['title']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

/// =====================
  /// BARRA DE PESQUISA
  /// =====================

Widget searchBarSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Pesquisar destinos...',
          prefixIcon: const Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    ),
  );
}

  /// =====================
  /// BUILD PRINCIPAL
  /// =====================
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    
    return Scaffold(
     
      appBar: AppBar(
        title: const Text('Explore Mundo 🌍'),
      ),
      body: ListView(
        children: [
          bannerSection(context),
          const SizedBox(height: 16),
          searchBarSection(),

          // TÍTULO
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Explore Mundo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Os melhores destinos para você',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.star, color: Colors.orange[500]),
                const SizedBox(width: 4),
                Text(
                  destinos[_currentPage]['rating']!, //valiação muda conforme slide,Tudo sincronizado via _currentPage
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // BOTÕES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButtonColumn(color, Icons.search, 'DESTINOS'),
              _buildButtonColumn(color, Icons.calendar_month, 'PACOTES'),
              _buildButtonColumn(color, Icons.phone, 'CONTATO'),
              _buildButtonColumn(
                color,
                Icons.info_outline,
                'SOBRE NÓS',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SobreNosPage(),
                    ),
                  );
                },
              ),
            ],
          ),

          // TEXTO
          const Padding(
            padding: EdgeInsets.all(32),
            child: Text(
              'A Explore Mundo é uma agência de viagens especializada em experiências '
              'inesquecíveis. Explore destinos incríveis, consulte pacotes exclusivos '
              'e realize sua reserva com praticidade e segurança.',
            ),
          ),
          destinosPopularesSection(),
        ],
      ),
    );
  }

  @override
  /// =====================
/// DESTINOS POPULARES
/// =====================
Widget destinosPopularesSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TÍTULO
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Destinos populares', // título da seção
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // LISTA HORIZONTAL
   SizedBox(
  height: 220,
  //Exibe barra de rolagem horizontal
  child: Scrollbar(
    controller: _destinosScrollController,
    thumbVisibility: true, // 👈 barra sempre visível
    trackVisibility: true, // 👈 trilho (opcional)
    //Lista horizontal
    child: ListView.builder(
      controller: _destinosScrollController,
      scrollDirection: Axis.horizontal,
      itemCount: destinos.length,
      itemBuilder: (context, index) {
        final destino = destinos[index];

        return Container(
          width: 160,
          margin: EdgeInsets.only(
            left: index == 0 ? 24 : 12,
            right: index == destinos.length - 1 ? 24 : 24,
          ),
         child: InkWell(
  borderRadius: BorderRadius.circular(16),
  onTap: () {
    //Envia o mapa completo .Página de destino fica genérica e reutilizável
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DestinoPage(
          destino: destino,
        ),
      ),
    );
  },
  child: Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // IMAGEM
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
          child: Image.asset(
            destino['image']!,
            height: 110,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                destino['title']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                destino['local']!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    destino['rating']!,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),

        );
      },
    ),
  ),
),

      ],
    ),
  );
}

}


/// =====================
/// TELA DESTINO
/// =====================

class DestinoPage extends StatelessWidget {
  final Map<String, String> destino;

  const DestinoPage({super.key, required this.destino});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destino['title']!), //Título dinâmico
      ),

      body: ListView(
        children: [
          // IMAGEM DO DESTINO
          Image.asset(
            destino['image']!, //Imagem dinâmica
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // CONTEÚDO
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TÍTULO
                Text(
                  destino['title']!,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // AVALIAÇÃO
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.orange),
                    SizedBox(width: 4),
                    Text(
                      '4.8 (1.254 avaliações)',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // DESCRIÇÃO
                const Text(
                  'Descrição',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Este destino oferece experiências inesquecíveis, '
                  'paisagens deslumbrantes, cultura rica e opções incríveis '
                  'de lazer, gastronomia e hospedagem. Ideal para quem busca '
                  'momentos únicos e memoráveis.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 32),

                // BOTÃO RESERVAR
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    //Simula reserva, Feedback imediato ao usuário
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Reserva iniciada com sucesso!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Reservar agora',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/// =====================
/// TELA SOBRE NÓS
/// =====================
/// Tela simples, estática, correta para StatelessWidget.
class SobreNosPage extends StatelessWidget {
  const SobreNosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre a Explore Mundo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Quem somos',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'A Explore Mundo é uma agência de viagens especializada em criar '
              'experiências únicas e inesquecíveis, oferecendo pacotes '
              'personalizados com segurança e praticidade.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'Nossa missão',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Conectar pessoas a experiências incríveis ao redor do mundo.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
