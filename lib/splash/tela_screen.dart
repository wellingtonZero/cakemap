import 'dart:async';
import 'package:confeitaria_marketplace/telas/home.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TelaScreen extends StatefulWidget {
  const TelaScreen({super.key});

  @override
  State<TelaScreen> createState() => _TelaScreenState();
}

class _TelaScreenState extends State<TelaScreen> {
  Timer? _timer;
  int _biteCount = 0;
  RiveAnimationController? _animationController;
  bool _riveError = false;

  @override
  void initState() {
    super.initState();
    _startNavigationTimer();
  }

  void _startNavigationTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      _biteCount++;
      if (_biteCount >= 3) {
        _timer?.cancel();
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFD4CD),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 180,
                  child: _riveError 
                      ? const Icon(Icons.error, size: 50, color: Colors.red)
                      : RiveAnimation.asset(
                          'assets/logo.riv',
                          fit: BoxFit.contain,
                          onInit: _onRiveInit,
                        ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'wellingtondevsoft',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onRiveInit(Artboard artboard) {
    try {
      final controller = StateMachineController.fromArtboard(artboard, 'anime');
      if (controller != null) {
        _animationController = controller;
        artboard.addController(controller);
      } else {
        _handleRiveError();
      }
    } catch (e) {
      _handleRiveError();
    }
  }

  void _handleRiveError() {
    if (mounted) {
      setState(() {
        _riveError = true;
      });
    }
  }
}