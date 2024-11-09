import 'package:dispute_of_sovereigns/helpers/auxiliares.dart';
import 'package:flutter/material.dart';
import 'package:hexagon/hexagon.dart';
import 'package:dispute_of_sovereigns/constants/colors.dart';
import 'package:dispute_of_sovereigns/models/grafos.dart';

class RotaVitoria extends StatefulWidget {
  const RotaVitoria({super.key, required this.grafo});

  final Grafo grafo;

  @override
  State<RotaVitoria> createState() => _RotaVitoriaState();
}

class _RotaVitoriaState extends State<RotaVitoria> {
  // Parâmetro que define o tamanho do tabuleiro:
  int tamanho = 8;
  // Parâmetro para guardar o tamanho do lado do tabuleiro:
  int lado = 9;

  // Parâmetro que define o tipo de formação hexagonal:
  HexagonType tipo = HexagonType.FLAT;

  // Grafo que representa o tabuleiro:
  Grafo novoGrafo = Grafo();

  void atualizar() {
    setState(() {
      novoGrafo = novoGrafo;
      novoGrafo;
    });
  }

  @override
  void initState() {
    // Copiando os nós do grafo original para o novo grafo:
    for (No no in widget.grafo.adjacencias.keys) {
      novoGrafo.addNo('${no.id}_rota', no.posicao, no.ocupado, no.peca,
          no.equipe, no.mover, no.visivel);
    }

    // Copiando as arestas do grafo original para o novo grafo:
    for (No no in widget.grafo.adjacencias.keys) {
      for (No adj in widget.grafo.adjacencias[no]!) {
        No noGrafo = novoGrafo.getNo('${no.id}_rota')!;
        No adjGrafo = novoGrafo.getNo('${adj.id}_rota')!;
        novoGrafo.addAresta(noGrafo, adjGrafo);
      }
    }

    No? sentinela;

    // Encontrando o nó sentinela:
    for (No no in novoGrafo.adjacencias.keys) {
      if (no.peca == 'sentinela' && no.equipe == 'brancas') {
        sentinela = no;
        break;
      }
    }

    // Desenhando a rota da sentinela até a base inimiga:
    desenharCaminho(sentinela!.id, '(0, -8)_rota', novoGrafo, atualizar);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: _buildGrid(context, tipo),
    );
  }

  // Mudar a cor das casas do tabuleiro
  Color getColor(int q, int r, int tamanho, Grafo grafo) {
    No no = grafo.getNo('($q, $r)_rota')!;

    if (no.equipe == 'brancas' && no.peca == 'sentinela') {
      return AppColors.lightlbluegrey;
    } else {
      return AppColors.lightgrey;
    }
  }

  getPeca(int q, int r, Grafo grafo) {
    No no = grafo.getNo('($q, $r)_rota')!;

    if (no.peca == 'sentinela' && no.equipe == 'brancas') {
      {
        return CircleAvatar(
          backgroundColor: const Color(0xffaf2747),
          radius: 20,
          child: Image.asset(
            'assets/icons/visao.png',
            width: 25,
            height: 25,
          ),
        );
      }
    } else if (no.ocupado && no.peca == '') {
      return Icon(
        Icons.circle,
        color: AppColors.dark.withOpacity(0.5),
        size: 25,
      );
    } else if (no.ocupado && no.peca == 'inimigo') {
      return Icon(
        Icons.circle,
        color: AppColors.vermelhoClara.withOpacity(0.5),
        size: 25,
      );
    } else if (no.ocupado && no.peca == 'aliado') {
      return Icon(
        Icons.circle,
        color: AppColors.primariaEscura.withOpacity(0.7),
        size: 25,
      );
    }
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
          color: AppColors.dark,
          depth: tamanho,
          buildTile: (coordinates) => HexagonWidgetBuilder(
            color: getColor(coordinates.q, coordinates.r, tamanho, novoGrafo),
            padding: 0.2,
            cornerRadius: 0.0,
            child: getPeca(coordinates.q, coordinates.r, novoGrafo),
          ),
        ),
      ),
    );
  }
}
