import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';

// Classe da Aplicação:
class DisputaDosSoberanos extends StatelessWidget {
  const DisputaDosSoberanos({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Disputa dos Soberanos',
      debugShowCheckedModeBanner: false,
      home: Tabuleiro(),
    );
  }
}

// Classe do Tabuleiro:
class Tabuleiro extends StatefulWidget {
  const Tabuleiro({super.key});

  @override
  State<Tabuleiro> createState() => _TabuleiroState();
}

class _TabuleiroState extends State<Tabuleiro> {
  // Parâmetro que define o tamanho do tabuleiro:
  int tamanho = 8;
  // Parâmetro para guardar o tamanho do lado do tabuleiro:
  int lado = 9;

  // Parâmetro que define o tipo de formação hexagonal:
  HexagonType tipo = HexagonType.FLAT;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d101b),
      body: Positioned.fill(
        child: _buildGrid(context, tipo),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, HexagonType type) {
    return InteractiveViewer(
      child: Center(
        child: HexagonGrid(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: 3,
            right: 3,
          ),
          hexType: type,
          color: const Color(0xff0d101b),
          depth: tamanho,
          buildTile: (coordinates) => HexagonWidgetBuilder(
            color: Colors.black,
            padding: 0.08,
            cornerRadius: 0.0,
            child: GestureDetector(
              child: Text("${coordinates.q}"),
            ),
          ),
        ),
      ),
    );
  }
}
