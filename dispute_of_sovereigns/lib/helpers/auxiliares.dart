// ########## Funções auxiliares para o jogo ##########

/* 
 * Função para encontrar os vizinhos de uma casa no tabuleiro hexagonal.
 * É utilizada pela função de criar arestas, para saber quais casas são vizinhas.
 * 
 * Parâmetros:
 * - posicao: coordenadas axial (q, r) da casa no tabuleiro que se deseja saber os vizinhos.
 * - lado: tamanho do lado do tabuleiro.
 * 
 * Retorno:
 * - Lista de Mapas, onde cada mapa contém as coordenadas (q, r) de uma casa vizinha do nó na posição informada.
 */
import 'package:dispute_of_sovereigns/models/grafos.dart';
import 'package:flutter/material.dart';

List<Map<String, int>> casasVizinhas(Map<String, int> posicao, int lado) {
  // Direções possíveis para encontrar os vizinhos:
  List<List<int>> direcoes = [
    [0, 1],
    [-1, 1],
    [-1, 0],
    [0, -1],
    [1, -1],
    [1, 0]
  ];

  // Lista de Mapas com os vizinhos:
  List<Map<String, int>> vizinhos = [];

  // Percorrer as direções:
  for (List<int> direcao in direcoes) {
    // Somar a direção com posição atual para encontrar a casa vizinha da determinada direção:
    int novoQ = posicao['q']! + direcao[0];
    int novoR = posicao['r']! + direcao[1];

    // Verifica se a posição somada com a direção está dentro dos limites do tabuleiro:
    if ((novoQ + novoR >= -lado + 1 && novoQ + novoR < lado) &&
        (novoQ >= -lado + 1 && novoQ < lado) &&
        (novoR >= -lado + 1 && novoR < lado)) {
      // Adiciona a posição na lista de vizinhos:
      vizinhos.add({'q': novoQ, 'r': novoR});
    }
  }

  // Retorna a lista de vizinhos:
  return vizinhos;
}

/* 
 * Função para criar nós do grafo representando o tabuleiro. E chamar a função de criar arestas.
 * 
 * Parâmetros:
 * - grafo: Grafo ao qual os nós pertencerão.
 * - lado: tamanho do lado do tabuleiro.
 * 
 */
void criarNos(Grafo grafo, int lado) {
  // Percorre todas as casas do tabuleiro (como se fosse um quadrado, não um hexagono):
  for (int q = -lado + 1; q < lado; q++) {
    for (int r = -lado + 1; r < lado; r++) {
      // Verifica se está dentro dos limites do tabuleiro:
      if (q + r >= -lado + 1 && q + r < lado) {
        // posição da casa da iteração atual:
        String casaAtual = '($q, $r)';

        // Adiciona o nó representando a casa atual do tabuleiro:
        grafo.addNo(casaAtual, {'q': q, 'r': r}, false, '', '', false);
      }
    }
  }
  // Chama a função para criar as arestas do grafo:
  criarArestas(grafo, lado);
}

/* 
 * Função para criar arestas dos nós do grafo representando o tabuleiro.
 * 
 * Parâmetros:
 * - grafo: Grafo.
 * - lado: tamanho do lado do tabuleiro.
 * 
 */
void criarArestas(Grafo grafo, int lado) {
  // Percorre todas as casas do tabuleiro (como se fosse um quadrado, não um hexagono):
  for (int q = -lado + 1; q < lado; q++) {
    for (int r = -lado + 1; r < lado; r++) {
      // Verifica se está dentro dos limites do tabuleiro:
      if (q + r >= -lado + 1 && q + r < lado) {
        // posição da casa da iteração atual:
        String casaAtual = '($q, $r)';

        // Lista com as posições das casas vizinhas da casa atual:
        List<Map<String, int>> vizinhos = casasVizinhas({'q': q, 'r': r}, lado);

        // Percorre cada vizinho da lista de vizinhos:
        for (Map<String, int> vizinho in vizinhos) {
          // posição da casa vizinha da iteração atual:
          String casaVizinha = '(${vizinho['q']}, ${vizinho['r']})';

          // Adiciona a aresta entre a casa da iteração atual, e o vizinho da iteração de vizinhos atual:
          grafo.addAresta(grafo.getNo(casaAtual)!, grafo.getNo(casaVizinha)!);
        }
      }
    }
  }

  // Imprime a lista de adjacências do grafo no console:
  grafo.printGrafo();
}

// Mudar a cor das casas do tabuleiro
Color getColor(int q, int r, int tamanho) {
  if (q == 0 && (r == tamanho || r == -tamanho)) {
    // return const Color(0xffee243d);
    return const Color(0xff334224);
  } else if (q.isEven && r.isEven) {
    // return const Color(0xff281a2d);
    return const Color(0xff739552);
  } else {
    // return const Color(0xff6b2341);
    // return const Color(0xffffff33);
    return const Color(0xffebecd0);
  }
}

// Define a aparencia da casa do tabuleiro (personagens)
getPeca(int q, int r, Grafo grafo) {
  No no = grafo.getNo('($q, $r)')!;

  Color equipe = no.equipe == 'brancas'
      ? const Color(0xffaf2747)
      : no.equipe == 'pretas'
          ? const Color(0xff281a2d)
          : Colors.white;

  String icone = no.peca == 'conjurador'
      ? 'feiticeiro2.png'
      : no.peca == 'atacante'
          ? 'assassino.png'
          : no.peca == 'escudo'
              ? 'escudo.png'
              : no.peca == 'sentinela'
                  ? 'visao.png'
                  : '';

  if (no.mover && no.ocupado) {
    return GestureDetector(
      child: Icon(
        Icons.circle,
        color: Colors.red.withOpacity(0.35),
        size: 25,
      ),
    );
  }
  if (no.mover) {
    return GestureDetector(
      child: Icon(
        Icons.circle,
        color: Colors.black.withOpacity(0.35),
        size: 25,
      ),
    );
  }
  if (no.ocupado) {
    if (no.peca.isNotEmpty) {
      return CircleAvatar(
        backgroundColor: equipe,
        radius: 20,
        child: Image.asset(
          'icons/$icone',
          width: 25,
          height: 25,
        ),
      );
    } else {
      return const CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 17,
        child: Icon(
          Icons.question_mark_sharp,
          color: Color.fromARGB(255, 197, 13, 13),
          size: 15,
        ),
      );
    }
  }
}

// todo
void movimentar(Grafo grafo, dynamic coordinates, bool movendo, Map<String, String> casasAtivas, String casaMovendo, List<String> antigaNovaPosicao) {
  No no = grafo.getNo('(${coordinates.q}, ${coordinates.r})')!;

  print('Equipe: ${no.equipe}');

  if (no.ocupado) {
    print('Casa ocupada');

    if (movendo) {
      for (String no in casasAtivas.keys) {
        No noAtual = grafo.getNo(no)!;
        noAtual.mover = false;
      }
    }
    movendo = true;
    casasAtivas = calcularMovimentos('(${coordinates.q}, ${coordinates.r})', grafo);

    for (String no in casasAtivas.keys) {
      No noAtual = grafo.getNo(no)!;

      noAtual.mover = true;
    }

    casaMovendo = '(${coordinates.q}, ${coordinates.r})';
    antigaNovaPosicao[0] = casaMovendo;
  } else {
    print('Casa vazia');
    casaMovendo = '';
    antigaNovaPosicao[0] = '';
    antigaNovaPosicao[1] = '';
    if (movendo) {
      for (String no in casasAtivas.keys) {
        No noAtual = grafo.getNo(no)!;
        noAtual.mover = false;
      }
      movendo = false;
    }
  }
}

// Calcula os movimentos de cada peça
Map<String, String> calcularMovimentos(String origem, Grafo grafo) {
    No noOrigem = grafo.getNo(origem)!;

    Map<String, String> visitados = {};

    switch (noOrigem.peca) {
      case ('conjurador'):
        visitados = grafo.bfsProfundidade(noOrigem, 2);

        // Casas invalidas para movimento dessa peca
        List<String> invalidos = [];

        for (String no in visitados.keys) {
          var q = int.parse(no.split(', ')[0].split('(')[1]);
          var r = int.parse(no.split(', ')[1].split(')')[0]);

          if ((q.isOdd || r.isOdd)) {
            invalidos.add(no);
          }
        }

        for (String no in invalidos) {
          visitados.remove(no);
        }
        break;
      case 'atacante':
        visitados = grafo.bfsProfundidade(noOrigem, 2);
        break;
      case 'escudo':
        visitados = grafo.bfsProfundidade(noOrigem, 1);

        List<String> invalidos = [];

        for (String no in visitados.keys) {
          var q = int.parse(no.split(', ')[0].split('(')[1]);
          var r = int.parse(no.split(', ')[1].split(')')[0]);

          if ((q.isEven && r.isEven)) {
            invalidos.add(no);
          }
        }

        for (String no in invalidos) {
          visitados.remove(no);
        }
        break;
      case 'sentinela':
        visitados = grafo.bfsProfundidade(noOrigem, 1);
        break;
      default:
        break;
    }

    return visitados;
  }

  void moverPeca(String origem, String destino, Grafo grafo, Map<String, String> casasAtivas, bool movendo, String casaMovendo, List<String> antigaNovaPosicao) {
    No noOrigem = grafo.getNo(origem)!;
    No noDestino = grafo.getNo(destino)!;

    noDestino.ocupado = true;
    noDestino.peca = noOrigem.peca;
    noDestino.equipe = noOrigem.equipe;

    noOrigem.ocupado = false;
    noOrigem.peca = '';
    noOrigem.equipe = '';

    for (String no in casasAtivas.keys) {
      No noAtual = grafo.getNo(no)!;

        noAtual.mover = false;
    }

    movendo = false;
    casaMovendo = '';
    antigaNovaPosicao[1] = destino;
  }