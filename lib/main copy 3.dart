import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: StatelessWidgetExemplo("Olá Flutter - Exemplo Completo"),
    ),
  );
}

class StatelessWidgetExemplo extends StatelessWidget {
  final String appBarTitle;

  StatelessWidgetExemplo(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Botão de busca pressionado');
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              print('Menu pressionado');
            },
          ),
        ],
      ),
      // BARRA LATERAL (DRAWER) - ADICIONADA AQUI
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person, size: 40),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Usuário Exemplo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'usuario@exemplo.com',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Início'),
              onTap: () {
                Navigator.pop(context);
                print('Início selecionado');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                print('Configurações selecionadas');
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ajuda'),
              onTap: () {
                Navigator.pop(context);
                print('Ajuda selecionada');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () {
                Navigator.pop(context);
                print('Sair selecionado');
              },
            ),
          ],
        ),
      ),
      // BOTÃO FLUTUANTE (Floating Action Button)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Botão flutuante pressionado!');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Botão pressionado!'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Adicionar item',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Exemplo Completo de Widget',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Icon(
              Icons.flutter_dash,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Macoratti .net',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                print('Botão elevado pressionado');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Bem-vindo ao Flutter!'),
                  ),
                );
              },
              child: Text('Clique aqui'),
            ),
          ],
        ),
      ),
      
      // BARRA DE NAVEGAÇÃO INFERIOR (Bottom Navigation Bar)
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
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
          print('Índice selecionado: $index');
        },
      ),
    );
  }
}