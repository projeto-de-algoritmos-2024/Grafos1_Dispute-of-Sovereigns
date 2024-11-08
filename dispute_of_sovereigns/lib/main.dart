import 'package:dispute_of_sovereigns/constants/colors.dart';
import 'package:dispute_of_sovereigns/models/grafos.dart';
import 'package:dispute_of_sovereigns/pages/lista_grafo.dart';
import 'package:flutter/material.dart';
import 'package:dispute_of_sovereigns/pages/tabuleiro.dart';

// Classe da Aplicação:
class DisputaDosSoberanos extends StatelessWidget {
  const DisputaDosSoberanos({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Disputa dos Soberanos',
      debugShowCheckedModeBanner: false,
      home: Jogo(),
    );
  }
}

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  @override
  Widget build(BuildContext context) {
    const int qntdAbas = 2;

    // Cria um novo grafo:
    Grafo grafo = Grafo();

    return DefaultTabController(
      length: qntdAbas,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkblue,
          titleSpacing: 0,
          title: const TabBar(
            labelColor: AppColors.lightlbluegrey,
            textScaler: TextScaler.linear(1.35),
            dividerHeight: 0,
            indicatorColor: AppColors.darkdblue,
            indicatorPadding:
                EdgeInsets.only(left: -20, right: -20, bottom: -4),
            tabs: [
              Tab(text: "Jogo"),
              Tab(text: "Grafo"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Tabuleiro(grafo: grafo),
            VisualizaGrafo(grafo: grafo),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const DisputaDosSoberanos());
}
