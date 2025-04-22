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
    String imageAsset = 'assets/images/rosquinha.png';
    // Aqui você pode trocar para: rosquinha_mordida1.png, rosquinha_mordida2.png etc
    if (biteCount == 1) imageAsset = 'assets/images/rosquinha_mordida1.png';
    if (biteCount == 2) imageAsset = 'assets/images/rosquinha_mordida2.png';
    if (biteCount >= 3) imageAsset = 'assets/images/rosquinha_mordida3.png';

    return Scaffold(
        backgroundColor: const Color(0xffFFD4CD),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Image.asset('assets/images/logo.jpeg', height: 180),
            ),
            Expanded(
              child: Center(
                child: RotationTransition(
                  turns: _rotationController,
                  child: Image.asset(imageAsset, width: 200),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 20.0),
            child: const Text(
              'wellingtondevsoft',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              )
            ),
            )
          ],
        ));
  }
}

