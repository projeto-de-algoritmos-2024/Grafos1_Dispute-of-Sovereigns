import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:dispute_of_sovereigns/constants/colors.dart';
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

  // Instância do Grafo que representa o tabuleiro:
  Grafo tabuleiroGrafo = Grafo();

  @override
  void initState() {
    criarNos(tabuleiroGrafo, lado);

    tabuleiroGrafo.getNo('(0, 8)')!.ocupado = true;
    tabuleiroGrafo.getNo('(0, 8)')!.peca = 'sentinela';
    tabuleiroGrafo.getNo('(0, 8)')!.equipe = 'brancas';

    tabuleiroGrafo.getNo('(0, -8)')!.ocupado = true;
    tabuleiroGrafo.getNo('(0, -8)')!.peca = 'sentinela';
    tabuleiroGrafo.getNo('(0, -8)')!.equipe = 'pretas';

    tabuleiroGrafo.getNo('(-2, -6)')!.ocupado = true;
    tabuleiroGrafo.getNo('(-2, -6)')!.peca = 'conjurador';
    tabuleiroGrafo.getNo('(-2, -6)')!.equipe = 'pretas';

    tabuleiroGrafo.getNo('(2, 6)')!.ocupado = true;
    tabuleiroGrafo.getNo('(2, 6)')!.peca = 'conjurador';
    tabuleiroGrafo.getNo('(2, 6)')!.equipe = 'brancas';

    tabuleiroGrafo.getNo('(2, -8)')!.ocupado = true;
    tabuleiroGrafo.getNo('(2, -8)')!.peca = 'conjurador';
    tabuleiroGrafo.getNo('(2, -8)')!.equipe = 'pretas';

    tabuleiroGrafo.getNo('(-2, 8)')!.ocupado = true;
    tabuleiroGrafo.getNo('(-2, 8)')!.peca = 'conjurador';
    tabuleiroGrafo.getNo('(-2, 8)')!.equipe = 'brancas';

    tabuleiroGrafo.getNo('(-1, -7)')!.ocupado = true;
    tabuleiroGrafo.getNo('(-1, -7)')!.peca = 'escudo';
    tabuleiroGrafo.getNo('(-1, -7)')!.equipe = 'pretas';

    tabuleiroGrafo.getNo('(1, 7)')!.ocupado = true;
    tabuleiroGrafo.getNo('(1, 7)')!.peca = 'escudo';
    tabuleiroGrafo.getNo('(1, 7)')!.equipe = 'brancas';

    tabuleiroGrafo.getNo('(1, -8)')!.ocupado = true;
    tabuleiroGrafo.getNo('(1, -8)')!.peca = 'escudo';
    tabuleiroGrafo.getNo('(1, -8)')!.equipe = 'pretas';

    tabuleiroGrafo.getNo('(-1, 8)')!.ocupado = true;
    tabuleiroGrafo.getNo('(-1, 8)')!.peca = 'escudo';
    tabuleiroGrafo.getNo('(-1, 8)')!.equipe = 'brancas';

    tabuleiroGrafo.getNo('(-1, -6)')!.ocupado = true;
    tabuleiroGrafo.getNo('(-1, -6)')!.peca = 'atacante';
    tabuleiroGrafo.getNo('(-1, -6)')!.equipe = 'pretas';

    tabuleiroGrafo.getNo('(1, 6)')!.ocupado = true;
    tabuleiroGrafo.getNo('(1, 6)')!.peca = 'atacante';
    tabuleiroGrafo.getNo('(1, 6)')!.equipe = 'brancas';

    tabuleiroGrafo.getNo('(1, -7)')!.ocupado = true;
    tabuleiroGrafo.getNo('(1, -7)')!.peca = 'atacante';
    tabuleiroGrafo.getNo('(1, -7)')!.equipe = 'pretas';

    tabuleiroGrafo.getNo('(-1, 7)')!.ocupado = true;
    tabuleiroGrafo.getNo('(-1, 7)')!.peca = 'atacante';
    tabuleiroGrafo.getNo('(-1, 7)')!.equipe = 'brancas';

    tabuleiroGrafo.getNo('(-3, -5)')!.ocupado = true;
    tabuleiroGrafo.getNo('(-3, -5)')!.peca = 'atacante';
    tabuleiroGrafo.getNo('(-3, -5)')!.equipe = 'pretas';

    tabuleiroGrafo.getNo('(3, 5)')!.ocupado = true;
    tabuleiroGrafo.getNo('(3, 5)')!.peca = 'atacante';
    tabuleiroGrafo.getNo('(3, 5)')!.equipe = 'brancas';

    tabuleiroGrafo.getNo('(3, -8)')!.ocupado = true;
    tabuleiroGrafo.getNo('(3, -8)')!.peca = 'atacante';
    tabuleiroGrafo.getNo('(3, -8)')!.equipe = 'pretas';

    tabuleiroGrafo.getNo('(-3, 8)')!.ocupado = true;
    tabuleiroGrafo.getNo('(-3, 8)')!.peca = 'atacante';
    tabuleiroGrafo.getNo('(-3, 8)')!.equipe = 'brancas';

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
            child: GestureDetector(child: getPeca(coordinates.q, coordinates.r, tabuleiroGrafo), onTap: (){
              movimentar(tabuleiroGrafo, coordinates, movendo, casasAtivas, casaMovendo, antigaNovaPosicao);
            },),
          ),
        ),
      ),
    );
  }
}
