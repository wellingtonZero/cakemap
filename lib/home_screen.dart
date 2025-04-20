
import 'package:confeitaria_marketplace/client_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/fundo.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>ClientScreen()));
                    print('Botão "Sou Cliente" pressionado');
                  },
                  child: const Text('Sou Cliente',
                      style: TextStyle(fontSize: 25.0)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Adicione a lógica para quando o botão "Sou Confeiteiro" for pressionado
                    print('Botão "Sou Confeiteiro" pressionado');
                  },
                  child: const Text('Sou Confeiteiro',
                      style: TextStyle(fontSize: 25.0)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
