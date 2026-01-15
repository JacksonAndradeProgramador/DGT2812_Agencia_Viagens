import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      title: 'App com Múltiplas Páginas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrimeiraPagina(), // Página inicial
    ),
  );
}

// ========== PRIMEIRA PÁGINA ==========
class PrimeiraPagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Primeira Página'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SegundaPagina(
                    mensagem: 'Vindo do ícone de info!',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Menu de Navegação',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Selecione uma página',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.blue),
              title: Text('Página Inicial'),
              selected: true,
              onTap: () {
                Navigator.pop(context); // Fecha o drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.next_plan, color: Colors.green),
              title: Text('Segunda Página'),
              onTap: () {
                Navigator.pop(context); // Fecha o drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SegundaPagina(
                      mensagem: 'Navegando pelo menu!',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey),
              title: Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                // Poderia navegar para uma página de configurações
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 30),
            Text(
              'Bem-vindo à Primeira Página!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Esta é a página inicial do aplicativo.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 40),
            
            // BOTÃO 1: Navegação simples
            ElevatedButton(
              onPressed: () {
                // Navega para a Segunda Página
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SegundaPagina(
                      mensagem: 'Olá da Primeira Página!',
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text(
                  'Ir para Segunda Página',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // BOTÃO 2: Navegação com animação personalizada
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SegundaPagina(
                      mensagem: 'Com animação personalizada!',
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.easeInOut;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 500),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_forward),
                    SizedBox(width: 10),
                    Text(
                      'Navegar com Animação',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // BOTÃO 3: Navegação com retorno de dados
            ElevatedButton(
              onPressed: () async {
                // Aguarda retorno da segunda página
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SegundaPagina(
                      mensagem: 'Aguardando seu retorno!',
                      permiteRetorno: true,
                    ),
                  ),
                );
                
                // Mostra o resultado retornado
                if (resultado != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Retornou com: $resultado'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text(
                  'Navegar e Retornar Dados',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            
            SizedBox(height: 50),
            Text(
              'Dica: Você também pode usar o menu lateral\nou o botão de info no canto superior direito.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[500],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Você está na Primeira Página!'),
            ),
          );
        },
        child: Icon(Icons.home),
        tooltip: 'Página Inicial',
      ),
    );
  }
}

// ========== SEGUNDA PÁGINA ==========
class SegundaPagina extends StatelessWidget {
  final String mensagem;
  final bool permiteRetorno;

  SegundaPagina({
    required this.mensagem,
    this.permiteRetorno = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segunda Página'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Retorna para a página anterior
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[50]!, Colors.purple[50]!],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  size: 100,
                  color: Colors.amber,
                ),
                SizedBox(height: 30),
                Text(
                  'Você chegou à Segunda Página!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Mensagem Recebida:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '"$mensagem"',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.blue[800],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                
                // BOTÃO para voltar
                ElevatedButton(
                  onPressed: () {
                    if (permiteRetorno) {
                      // Retorna com dados para a primeira página
                      Navigator.pop(context, 'Dados retornados com sucesso!');
                    } else {
                      // Volta simplesmente
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 10),
                      Text(
                        permiteRetorno ? 'Voltar com Dados' : 'Voltar para Home',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                
                // BOTÃO para abrir diálogo
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Diálogo de Exemplo'),
                        content: Text('Esta é uma caixa de diálogo na Segunda Página.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Fechar'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context); // Volta para primeira página
                            },
                            child: Text('Voltar para Home'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Text('Abrir Diálogo'),
                  ),
                ),
                
                SizedBox(height: 50),
                Text(
                  'Use o botão "Voltar" do AppBar\nou o botão abaixo para retornar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega de volta para a primeira página
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PrimeiraPagina(),
            ),
          );
        },
        child: Icon(Icons.reply),
        tooltip: 'Substituir página',
      ),
      
      // Barra inferior com informações
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Center(
            child: Text(
              'Segunda Página • Exemplo de Navegação',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        color: Colors.deepPurple,
      ),
    );
  }
}