import 'package:dispute_of_sovereigns/constants/colors.dart';
import 'package:dispute_of_sovereigns/models/grafos.dart';
import 'package:dispute_of_sovereigns/pages/inicio.dart';
import 'package:dispute_of_sovereigns/pages/lista_grafo.dart';
import 'package:dispute_of_sovereigns/pages/rota_vitoria.dart';
import 'package:dispute_of_sovereigns/route_generator.dart';
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
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: Home(),
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
    const int qntdAbas = 3;

    // Cria um novo grafo:
    Grafo grafo = Grafo();

    return DefaultTabController(
      length: qntdAbas,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkblue,
          titleSpacing: 0,
          leadingWidth: 20,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.lightlbluegrey,
              size: 20,
            ), // Ícone personalizado
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const TabBar(
            labelColor: AppColors.lightlbluegrey,
            textScaler: TextScaler.linear(1.35),
            dividerHeight: 0,
            indicatorColor: AppColors.darkdblue,
            indicatorPadding:
                EdgeInsets.only(left: -20, right: -20, bottom: -4),
            tabs: [
              Tab(text: "Rota"),
              Tab(text: "Partida"),
              Tab(text: "Grafo"),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            RotaVitoria(grafo: grafo),
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
