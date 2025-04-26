import 'dart:async';
import 'package:confeitaria_marketplace/telas/home.dart';
import 'package:flutter/material.dart';

class TelaScreen extends StatefulWidget {
  const TelaScreen({super.key});

  @override
  State<TelaScreen> createState() => _TelaScreenState();
}

class _TelaScreenState extends State<TelaScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  int biteCount = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Inicializa a rotação infinita
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Controla o efeito de mordidas
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        biteCount++;
        if (biteCount >= 3) {
          _rotationController.stop();
          _timer.cancel();
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffFFD4CD),
      body: Stack(
        children: [
          // Conteúdo principal centralizado
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo centralizada
                Image.asset(
                  'assets/images/logo.jpeg', 
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          
          // Rodapé fixo na parte inferior
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'wellingtondevsoft',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}