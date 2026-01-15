import 'package:flutter/material.dart';

void main() => runApp(const ExploreMundoApp());

class ExploreMundoApp extends StatelessWidget {
  const ExploreMundoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore Mundo - Agência de Viagens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Método para construir botões com ícones
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 28),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Cores personalizadas
    const Color primaryColor = Color(0xFF2C3E50);
    const Color secondaryColor = Color(0xFF3498DB);
    const Color accentColor = Color(0xFFE74C3C);

    // ========== SEÇÃO DO BANNER ==========
    Widget bannerSection = SizedBox(
      height: 200,
      child: PageView(
        children: [
          GestureDetector(
            onTap: () {
              _showDestinationDialog(context, 'Paris, França');
            },
            child: Image.asset(
              'images/destino1.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onTap: () {
              _showDestinationDialog(context, 'Maldivas');
            },
            child: Image.asset(
              'images/destino2.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onTap: () {
              _showDestinationDialog(context, 'Japão');
            },
            child: Image.asset(
              'images/destino3.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );

    // ========== BARRA DE PESQUISA ==========
    Widget searchBar = Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: '🔍 Pesquisar destinos, pacotes...',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.search, color: secondaryColor),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pesquisa realizada!'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ),
        onSubmitted: (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Buscando por: $value'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );

    // ========== SEÇÃO DE TÍTULO PARA DESTINO DESTAQUE ==========
    Widget titleSection = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Resort Paradise Beach',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: primaryColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, color: accentColor, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Maldivas - Ilha Paradisíaca',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < 4 ? Colors.amber : Colors.grey[300],
                    size: 20,
                  );
                }),
              ),
              const SizedBox(height: 4),
              const Text(
                '4.5 (128 avaliações)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    // ========== SEÇÃO DE BOTÕES DE AÇÃO ==========
    Widget buttonSection = Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(secondaryColor, Icons.airplanemode_active, 'VOOS'),
          _buildButtonColumn(secondaryColor, Icons.hotel, 'HOTÉIS'),
          _buildButtonColumn(secondaryColor, Icons.beach_access, 'PASSEIOS'),
          _buildButtonColumn(secondaryColor, Icons.restaurant, 'GASTRONOMIA'),
        ],
      ),
    );

    // ========== SEÇÃO DE TEXTO DESCRITIVO ==========
    Widget textSection = Container(
      padding: const EdgeInsets.all(16),
      child: const Text(
        'Bem-vindo à Explore Mundo! Somos uma agência de viagens especializada '
        'em criar experiências únicas e memoráveis. Nossos pacotes incluem '
        'destinos exóticos, hospedagem premium, passeios guiados e toda a '
        'assistência necessária para sua viagem ser perfeita.\n\n'
        'Com mais de 15 anos de experiência, já levamos mais de 50.000 clientes '
        'para conhecer os lugares mais incríveis do mundo. Nossa missão é '
        'transformar sonhos em realidade, oferecendo segurança, conforto e '
        'aventura em cada viagem.',
        softWrap: true,
        style: TextStyle(
          fontSize: 16,
          height: 1.5,
          color: Color(0xFF555555),
        ),
      ),
    );

    // ========== SEÇÃO DE PACOTES EM DESTAQUE ==========
    Widget packagesSection = Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🌟 Pacotes em Destaque',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildPackageCard(
                  'Europa Clássica',
                  '10 dias - 4 países',
                  '\$2.499',
                  Colors.blue[100]!,
                ),
                _buildPackageCard(
                  'Caribe Tropical',
                  '7 dias - All Inclusive',
                  '\$1.899',
                  Colors.green[100]!,
                ),
                _buildPackageCard(
                  'Ásia Oriental',
                  '14 dias - Cultura e Aventura',
                  '\$3.299',
                  Colors.orange[100]!,
                ),
                _buildPackageCard(
                  'Patagônia',
                  '8 dias - Trekking',
                  '\$1.799',
                  Colors.purple[100]!,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore Mundo',
          style: TextStyle(
            fontWeight: FontWeight.bold,           
            fontSize: 20,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Você tem novas ofertas!'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Acessando seu perfil...'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context, primaryColor, secondaryColor),
      body: ListView(
        children: [
          bannerSection,
          searchBar,
          titleSection,
          buttonSection,
          packagesSection,
          textSection,
          _buildContactSection(context, secondaryColor),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBookingDialog(context);
        },
        backgroundColor: accentColor,
        child: const Icon(Icons.airplane_ticket, color: Colors.white),
        tooltip: 'Reservar Viagem',
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // ========== MÉTODOS AUXILIARES ==========

  // Método para construir card de pacote
  Widget _buildPackageCard(
      String title, String description, String price, Color color) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF2C3E50),
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFFE74C3C),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3498DB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'OFERTA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir o drawer (menu lateral)
  Drawer _buildDrawer(BuildContext context, Color primaryColor,
      Color secondaryColor) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.public,
                    size: 40,
                    color: Color(0xFF3498DB),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Explore Mundo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sua próxima aventura começa aqui!',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(context, Icons.explore, 'Destinos'),
          _buildDrawerItem(context, Icons.airplane_ticket, 'Pacotes'),
          _buildDrawerItem(context, Icons.calendar_today, 'Reservas'),
          _buildDrawerItem(context, Icons.phone, 'Contato'),
          _buildDrawerItem(context, Icons.info, 'Sobre Nós'),
          _buildDrawerItem(context, Icons.star, 'Avaliações'),
          _buildDrawerItem(context, Icons.settings, 'Configurações'),
          const Divider(),
          _buildDrawerItem(context, Icons.logout, 'Sair'),
        ],
      ),
    );
  }

  // Método para construir item do drawer
  ListTile _buildDrawerItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2C3E50)),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Acessando: $title'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }

  // Método para construir seção de contato
  Widget _buildContactSection(BuildContext context, Color secondaryColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📞 Fale Conosco',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Pronto para sua próxima aventura? Nossa equipe está disponível '
            'para ajudar você a planejar a viagem dos seus sonhos.',
            style: TextStyle(
              color: Color(0xFF555555),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ligando para nossa central...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.phone, size: 18),
                label: const Text('Ligar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enviando WhatsApp...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.chat, size: 18),
                label: const Text('WhatsApp'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Abrindo formulário de email...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: const Icon(Icons.email, size: 18),
                label: const Text('Email'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE74C3C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Método para construir bottom navigation bar
  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: const Color(0xFF3498DB),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explorar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      onTap: (index) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Navegando para: ${['Início', 'Explorar', 'Favoritos', 'Perfil'][index]}'),
            duration: const Duration(milliseconds: 500),
          ),
        );
      },
    );
  }

  // Método para mostrar diálogo de destino
  void _showDestinationDialog(BuildContext context, String destination) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🌴 $destination'),
        content: Text(
          'Clique para ver detalhes completos, fotos, '
          'pacotes disponíveis e fazer reservas para $destination.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Voltar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showBookingDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3498DB),
            ),
            child: const Text('Ver Pacotes'),
          ),
        ],
      ),
    );
  }

  // Método para mostrar diálogo de reserva
  void _showBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('✈️ Fazer Reserva'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Preencha os dados para sua reserva:'),
            const SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Destino Desejado',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Datas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Número de Pessoas',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reserva enviada! Em breve entraremos em contato.'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C3E50),
            ),
            child: const Text('Enviar Reserva'),
          ),
        ],
      ),
    );
  }
}