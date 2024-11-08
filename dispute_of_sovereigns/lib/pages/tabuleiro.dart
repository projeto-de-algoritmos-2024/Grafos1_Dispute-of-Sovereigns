import 'package:dispute_of_sovereigns/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:dispute_of_sovereigns/helpers/auxiliares.dart';
import 'package:dispute_of_sovereigns/models/grafos.dart';

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

    // Instância do Grafo que representa o tabuleiro:
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
            InteractiveViewer.builder(
              builder: (context, viewport) {
                return InteractiveViewer(child: Text("Pag 2"));
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Classe do Tabuleiro:
class Tabuleiro extends StatefulWidget {
  const Tabuleiro({super.key, required this.grafo});

  final Grafo grafo;

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
  void initState() {
    criarNos(widget.grafo, lado);

    widget.grafo.getNo('(0, 8)')!.ocupado = true;
    widget.grafo.getNo('(0, 8)')!.peca = 'sentinela';
    widget.grafo.getNo('(0, 8)')!.equipe = 'brancas';

    widget.grafo.getNo('(0, -8)')!.ocupado = true;
    widget.grafo.getNo('(0, -8)')!.peca = 'sentinela';
    widget.grafo.getNo('(0, -8)')!.equipe = 'pretas';

    super.initState();
  }

  bool movendo = false;
  String casaMovendo = '';
  List<String> antigaNovaPosicao = ['', ''];
  Map<String, String> casasAtivas = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // // TODO depois voltar a AppBar
      // appBar: AppBar(
      //   title: Text(
      //     'Partida',
      //     style: const TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //       fontStyle: FontStyle.italic,
      //     ),
      //   ),
      //   backgroundColor: const Color(0xffaf2747),
      //   centerTitle: true,
      // ),
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
            color: getColor(coordinates.q, coordinates.r, tamanho),
            padding: 0.08,
            cornerRadius: 0.0,
            child: GestureDetector(
              child: getPeca(coordinates.q, coordinates.r, widget.grafo),
              onTap: () {
                setState(() {
                  No? no =
                      widget.grafo.getNo('${coordinates.q}, ${coordinates.r}');

                  print(no);
                });
                // movimentar(widget.grafo, coordinates, movendo, casasAtivas,
                //     casaMovendo, antigaNovaPosicao);
              },
            ),
          ),
        ),
      ),
    );
  }
}
