import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:dispute_of_sovereigns/constants/colors.dart';
import 'package:dispute_of_sovereigns/helpers/auxiliares.dart';
import 'package:dispute_of_sovereigns/models/grafos.dart';

// Classe do Tabuleiro:
class Tabuleiro extends StatefulWidget {
  const Tabuleiro({super.key, required this.grafo});

  final Grafo grafo;

  @override
  State<Tabuleiro> createState() => _TabuleiroState();
}

class _TabuleiroState extends State<Tabuleiro>
    with AutomaticKeepAliveClientMixin {
  // Parâmetro que define o tamanho do tabuleiro:
  int tamanho = 8;
  // Parâmetro para guardar o tamanho do lado do tabuleiro:
  int lado = 9;

  // Parâmetro que define o tipo de formação hexagonal:
  HexagonType tipo = HexagonType.FLAT;

  // Grafo que representa o tabuleiro:
  late Grafo grafo;

  // Inicialização do estado:
  bool movendo = false;
  String casaMovendo = '';
  List<String> antigaNovaPosicao = ['', ''];
  Map<String, String> casasAtivas = {};

  void atualizar() {
    setState(() {
      grafo = widget.grafo;
      casasAtivas;
      movendo;
      casaMovendo;
      antigaNovaPosicao;
      grafo = grafo;
      grafo;
    });
    print('Atualizou');
  }

  @override
  void initState() {
    grafo = widget.grafo;
    criarNos(grafo, lado);

    // TODO criar uma função de setup do tabuleiro
    grafo.getNo('(0, 8)')!.ocupado = true;
    grafo.getNo('(0, 8)')!.peca = 'sentinela';
    grafo.getNo('(0, 8)')!.equipe = 'brancas';

    grafo.getNo('(0, -8)')!.ocupado = true;
    grafo.getNo('(0, -8)')!.peca = 'sentinela';
    grafo.getNo('(0, -8)')!.equipe = 'pretas';

    grafo.getNo('(-2, -6)')!.ocupado = true;
    grafo.getNo('(-2, -6)')!.peca = 'conjurador';
    grafo.getNo('(-2, -6)')!.equipe = 'pretas';

    grafo.getNo('(2, 6)')!.ocupado = true;
    grafo.getNo('(2, 6)')!.peca = 'conjurador';
    grafo.getNo('(2, 6)')!.equipe = 'brancas';

    grafo.getNo('(2, -8)')!.ocupado = true;
    grafo.getNo('(2, -8)')!.peca = 'conjurador';
    grafo.getNo('(2, -8)')!.equipe = 'pretas';

    grafo.getNo('(-2, 8)')!.ocupado = true;
    grafo.getNo('(-2, 8)')!.peca = 'conjurador';
    grafo.getNo('(-2, 8)')!.equipe = 'brancas';

    grafo.getNo('(-1, -7)')!.ocupado = true;
    grafo.getNo('(-1, -7)')!.peca = 'escudo';
    grafo.getNo('(-1, -7)')!.equipe = 'pretas';

    grafo.getNo('(1, 7)')!.ocupado = true;
    grafo.getNo('(1, 7)')!.peca = 'escudo';
    grafo.getNo('(1, 7)')!.equipe = 'brancas';

    grafo.getNo('(1, -8)')!.ocupado = true;
    grafo.getNo('(1, -8)')!.peca = 'escudo';
    grafo.getNo('(1, -8)')!.equipe = 'pretas';

    grafo.getNo('(-1, 8)')!.ocupado = true;
    grafo.getNo('(-1, 8)')!.peca = 'escudo';
    grafo.getNo('(-1, 8)')!.equipe = 'brancas';

    grafo.getNo('(-1, -6)')!.ocupado = true;
    grafo.getNo('(-1, -6)')!.peca = 'atacante';
    grafo.getNo('(-1, -6)')!.equipe = 'pretas';

    grafo.getNo('(1, 6)')!.ocupado = true;
    grafo.getNo('(1, 6)')!.peca = 'atacante';
    grafo.getNo('(1, 6)')!.equipe = 'brancas';

    grafo.getNo('(1, -7)')!.ocupado = true;
    grafo.getNo('(1, -7)')!.peca = 'atacante';
    grafo.getNo('(1, -7)')!.equipe = 'pretas';

    grafo.getNo('(-1, 7)')!.ocupado = true;
    grafo.getNo('(-1, 7)')!.peca = 'atacante';
    grafo.getNo('(-1, 7)')!.equipe = 'brancas';

    grafo.getNo('(-3, -5)')!.ocupado = true;
    grafo.getNo('(-3, -5)')!.peca = 'atacante';
    grafo.getNo('(-3, -5)')!.equipe = 'pretas';

    grafo.getNo('(3, 5)')!.ocupado = true;
    grafo.getNo('(3, 5)')!.peca = 'atacante';
    grafo.getNo('(3, 5)')!.equipe = 'brancas';

    grafo.getNo('(3, -8)')!.ocupado = true;
    grafo.getNo('(3, -8)')!.peca = 'atacante';
    grafo.getNo('(3, -8)')!.equipe = 'pretas';

    grafo.getNo('(-3, 8)')!.ocupado = true;
    grafo.getNo('(-3, 8)')!.peca = 'atacante';
    grafo.getNo('(-3, 8)')!.equipe = 'brancas';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Positioned.fill(
        child: _buildGrid(context, tipo),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

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
          color: AppColors.dark,
          depth: tamanho,
          buildTile: (coordinates) => HexagonWidgetBuilder(
            color: getColor(coordinates.q, coordinates.r, tamanho, grafo,
                antigaNovaPosicao),
            padding: 0.08,
            cornerRadius: 0.0,
            child: GestureDetector(
              child: getPeca(coordinates.q, coordinates.r, grafo, movendo,
                  casasAtivas, casaMovendo, antigaNovaPosicao, atualizar),
              onTap: () {
                var retorno = movimentar(atualizar, grafo, coordinates, movendo,
                    casasAtivas, casaMovendo, antigaNovaPosicao);

                movendo = retorno[0];
                casaMovendo = retorno[1];
                casasAtivas = retorno[2];
                antigaNovaPosicao = retorno[3];
              },
            ),
          ),
        ),
      ),
    );
  }
}
