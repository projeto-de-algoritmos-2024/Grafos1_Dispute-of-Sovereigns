import 'dart:async';
import 'dart:math';
import 'package:dispute_of_sovereigns/constants/colors.dart';
import 'package:dispute_of_sovereigns/models/grafos.dart';
import 'package:flutter/material.dart';

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
        grafo.addNo(casaAtual, {'q': q, 'r': r}, false, '', '', false, false);
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
}

/* 
* Desenha o menor caminho do nó de início ao nó de fim.
* 
* Parâmetros:
* - inicio: ID do nó de início.
* - fim: ID do nó de fim.
*/
void desenharCaminho(
    String inicio, String fim, Grafo grafo, Function callback) {
  Map<String, String> visitados = grafo.bfs(grafo.getNo(inicio)!);

  List<String> caminho = grafo.montarMenorCaminho(
      visitados, grafo.getNo(inicio)!, grafo.getNo(fim)!);

  for (String no in caminho) {
    No noAtual = grafo.getNo(no)!;
    noAtual.ocupado = true;
  }
  callback();
}

// Mudar a cor das casas do tabuleiro
Color getColor(
    int q, int r, int tamanho, Grafo grafo, List<String> antigaNovaPosicao) {
  No no = grafo.getNo('($q, $r)')!;

  if (no.visivel) {
    if (antigaNovaPosicao[0] == '($q, $r)' ||
        antigaNovaPosicao[1] == '($q, $r)') {
      return AppColors.ativa;
    }
    if (q == 0 && (r == tamanho || r == -tamanho)) {
      return AppColors.primariaEscura;
    } else if (q.isEven && r.isEven) {
      return AppColors.primariaClara;
    } else {
      return AppColors.primariaBranca;
    }
  } else {
    if (antigaNovaPosicao[0] == '($q, $r)' ||
        antigaNovaPosicao[1] == '($q, $r)') {
      return AppColors.ativaFog;
    }
    if (q == 0 && (r == tamanho || r == -tamanho)) {
      return AppColors.primariaEscuraFog;
    } else if (q.isEven && r.isEven) {
      return AppColors.primariaClaraFog;
    } else {
      return AppColors.primariaBrancaFog;
    }
  }
}

// Define a aparencia da casa do tabuleiro (personagens)
getPeca(
    int q,
    int r,
    Grafo grafo,
    bool movendo,
    Map<String, String> casasAtivas,
    String casaMovendo,
    List<String> antigaNovaPosicao,
    int rodada,
    Function attTurno,
    Function mostrarVencedor,
    Function callback) {
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
      onTap: () {
        trocarLugarPeca(callback, casaMovendo, '($q, $r)', grafo, casasAtivas,
            movendo, casaMovendo, mostrarVencedor, antigaNovaPosicao);
        attTurno();
        Timer(const Duration(seconds: 8), () {
          computadorJoga(grafo, attTurno, mostrarVencedor);
        });
      },
    );
  }
  if (no.mover) {
    return GestureDetector(
      child: Icon(
        Icons.circle,
        color: Colors.black.withOpacity(0.35),
        size: 25,
      ),
      onTap: () {
        trocarLugarPeca(callback, casaMovendo, '($q, $r)', grafo, casasAtivas,
            movendo, casaMovendo, mostrarVencedor, antigaNovaPosicao);
        attTurno();
        Timer(const Duration(seconds: 11), () {
          computadorJoga(grafo, attTurno, mostrarVencedor);
        });
      },
    );
  }
  if (!no.visivel && no.equipe == "pretas") {
    return null;
  }
  if (no.ocupado) {
    if (no.peca.isNotEmpty) {
      return CircleAvatar(
        backgroundColor: equipe,
        radius: 20,
        child: Image.asset(
          'assets/icons/$icone',
          width: 33,
          height: 33,
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

movimentar(
    Function callback,
    Grafo grafo,
    dynamic coordinates,
    bool movendo,
    Map<String, String> casasAtivas,
    String casaMovendo,
    List<String> antigaNovaPosicao) {
  No no = grafo.getNo('(${coordinates.q}, ${coordinates.r})')!;

  if (no.ocupado && no.equipe == 'brancas') {
    if (movendo) {
      for (String no in casasAtivas.keys) {
        No noAtual = grafo.getNo(no)!;
        noAtual.mover = false;
      }
      callback();
    }
    movendo = true;
    casasAtivas =
        calcularMovimentos('(${coordinates.q}, ${coordinates.r})', grafo);

    for (String no in casasAtivas.keys) {
      No noAtual = grafo.getNo(no)!;

      noAtual.mover = true;
    }
    callback();

    casaMovendo = '(${coordinates.q}, ${coordinates.r})';
    antigaNovaPosicao[0] = casaMovendo;
  } else {
    casaMovendo = '';
    antigaNovaPosicao[0] = '';
    antigaNovaPosicao[1] = '';
    if (movendo) {
      for (String no in casasAtivas.keys) {
        No noAtual = grafo.getNo(no)!;
        noAtual.mover = false;
      }
      callback();
      movendo = false;
    }
  }

  return [movendo, casaMovendo, casasAtivas, antigaNovaPosicao];
}

void trocarLugarPeca(
    Function callback,
    String origem,
    String destino,
    Grafo grafo,
    Map<String, String> casasAtivas,
    bool movendo,
    String casaMovendo,
    Function mostrarVencedor,
    List<String> antigaNovaPosicao) {
  No noOrigem = grafo.getNo(origem)!;
  No noDestino = grafo.getNo(destino)!;

  No tempOrigem = No("${noOrigem.id}_temp", noOrigem.posicao, noOrigem.ocupado,
      noOrigem.peca, noOrigem.equipe, noOrigem.mover, noOrigem.visivel);
  No tempDestino = No(
      "${noDestino.id}_temp",
      noDestino.posicao,
      noDestino.ocupado,
      noDestino.peca,
      noDestino.equipe,
      noDestino.mover,
      noDestino.visivel);

  noDestino.ocupado = true;
  noDestino.peca = noOrigem.peca;
  noDestino.equipe = noOrigem.equipe;
  if (noDestino.equipe == 'brancas') {
    noDestino.visivel = true;
  }

  noOrigem.ocupado = false;
  noOrigem.peca = '';
  noOrigem.equipe = '';
  noOrigem.visivel = false;

  bool vitoria = false;

  if (tempOrigem.peca == 'sentinela' &&
      tempOrigem.equipe == 'brancas' &&
      tempDestino.id == '(0, -8)_temp') {
    vitoria = true;
    mostrarVencedor('Vitória verdadeira do Jogador');
  } else if (tempDestino.peca == 'sentinela' &&
      tempDestino.equipe == 'pretas') {
    vitoria = true;
    mostrarVencedor('Vitória do Jogador');
  }

  movendo = false;
  casaMovendo = '';
  if (noDestino.equipe == 'brancas') {
    antigaNovaPosicao[1] = destino;
  }

  callback();

  if (noDestino.equipe == 'brancas' && !vitoria) {
    List<No> revelados = pulsoSentinela(grafo, callback);

    Timer(const Duration(seconds: 12), () {
      colocarFog(revelados);
      callback();
    });
  }

  for (String no in casasAtivas.keys) {
    No noAtual = grafo.getNo(no)!;

    noAtual.mover = false;
  }

  callback();
}

List<No> pulsoSentinela(Grafo grafo, Function callback) {
  No? sentinela;

  for (No no in grafo.adjacencias.keys) {
    if (no.peca == 'sentinela' && no.equipe == 'brancas') {
      sentinela = no;
    }
  }

  List<No> nos = grafo.bfsPulso(sentinela!);

  List<No> retorno = [];
  retorno.addAll(nos);

  nos.removeAt(0);

  Timer.periodic(const Duration(milliseconds: 50), (timer) {
    No noAtual;

    if (nos.isNotEmpty) {
      noAtual = nos.removeAt(0);
    } else {
      timer.cancel();
      return;
    }

    noAtual.visivel = true;
    callback();
  });

  return retorno;
}

void colocarFog(List<No> revelados) {
  for (No no in revelados) {
    no.visivel = false;
  }
}

jogadorJogar(
    int rodada,
    Grafo grafo,
    dynamic coordinates,
    bool movendo,
    Map<String, String> casasAtivas,
    String casaMovendo,
    List<String> antigaNovaPosicao,
    Function attTurno,
    Function mostrarVencedor,
    Function callback) {
  if (rodada % 2 != 0) {
    // Jogador
    var retorno = movimentar(callback, grafo, coordinates, movendo, casasAtivas,
        casaMovendo, antigaNovaPosicao);

    movendo = retorno[0];
    casaMovendo = retorno[1];
    casasAtivas = retorno[2];
    antigaNovaPosicao = retorno[3];

    return [movendo, casaMovendo, casasAtivas, antigaNovaPosicao];
  }
}

computadorJoga(Grafo grafo, Function attTurno, Function mostrarVencedor) {
  List<No> nos = [];

  for (No no in grafo.adjacencias.keys) {
    if (no.equipe == 'pretas') {
      nos.add(no);
    }
  }

  // Selecionar um aleatoriamente com random:
  final random = Random();
  No noOrigem = nos[random.nextInt(nos.length)];

  Map<String, String> possibilidades = calcularMovimentos(noOrigem.id, grafo);

  if (possibilidades.isNotEmpty) {
    String destino =
        possibilidades.keys.elementAt(random.nextInt(possibilidades.length));

    No noDestino = grafo.getNo(destino)!;

    No tempOrigem = No(
        "${noOrigem.id}_temp",
        noOrigem.posicao,
        noOrigem.ocupado,
        noOrigem.peca,
        noOrigem.equipe,
        noOrigem.mover,
        noOrigem.visivel);
    No tempDestino = No(
        "${noDestino.id}_temp",
        noDestino.posicao,
        noDestino.ocupado,
        noDestino.peca,
        noDestino.equipe,
        noDestino.mover,
        noDestino.visivel);

    noDestino.ocupado = true;
    noDestino.peca = noOrigem.peca;
    noDestino.equipe = noOrigem.equipe;

    noOrigem.ocupado = false;
    noOrigem.peca = '';
    noOrigem.equipe = '';
    noOrigem.visivel = false;

    if (tempOrigem.peca == 'sentinela' &&
        tempOrigem.equipe == 'pretas' &&
        tempDestino.id == '(0, 8)_temp') {
      mostrarVencedor('Vitória verdadeira do Computador');
    } else if (tempDestino.peca == 'sentinela' &&
        tempDestino.equipe == 'brancas') {
      mostrarVencedor('Vitória do Computador');
    }

    attTurno();
  }
}

void vitoria(String vencedor, Function mostrarVencedor) {
  mostrarVencedor(vencedor);
}

void setupTabuleiro(Grafo grafo) {
  grafo.getNo('(0, 8)')!.ocupado = true;
  grafo.getNo('(0, 8)')!.peca = 'sentinela';
  grafo.getNo('(0, 8)')!.equipe = 'brancas';

  grafo.getNo('(0, -8)')!.ocupado = true;
  grafo.getNo('(0, -8)')!.peca = 'sentinela';
  grafo.getNo('(0, -8)')!.equipe = 'pretas';

  grafo.getNo('(0, 6)')!.ocupado = true;
  grafo.getNo('(0, 6)')!.peca = 'atacante';
  grafo.getNo('(0, 6)')!.equipe = 'brancas';

  grafo.getNo('(0, -6)')!.ocupado = true;
  grafo.getNo('(0, -6)')!.peca = 'atacante';
  grafo.getNo('(0, -6)')!.equipe = 'pretas';

  grafo.getNo('(-4, 8)')!.ocupado = true;
  grafo.getNo('(-4, 8)')!.peca = 'conjurador';
  grafo.getNo('(-4, 8)')!.equipe = 'brancas';

  grafo.getNo('(4, 4)')!.ocupado = true;
  grafo.getNo('(4, 4)')!.peca = 'conjurador';
  grafo.getNo('(4, 4)')!.equipe = 'brancas';

  grafo.getNo('(-4, -4)')!.ocupado = true;
  grafo.getNo('(-4, -4)')!.peca = 'conjurador';
  grafo.getNo('(-4, -4)')!.equipe = 'pretas';

  grafo.getNo('(4, -8)')!.ocupado = true;
  grafo.getNo('(4, -8)')!.peca = 'conjurador';
  grafo.getNo('(4, -8)')!.equipe = 'pretas';

  grafo.getNo('(0, 7)')!.ocupado = true;
  grafo.getNo('(0, 7)')!.peca = 'escudo';
  grafo.getNo('(0, 7)')!.equipe = 'brancas';

  grafo.getNo('(-3, 8)')!.ocupado = true;
  grafo.getNo('(-3, 8)')!.peca = 'escudo';
  grafo.getNo('(-3, 8)')!.equipe = 'brancas';

  grafo.getNo('(-1, 8)')!.ocupado = true;
  grafo.getNo('(-1, 8)')!.peca = 'escudo';
  grafo.getNo('(-1, 8)')!.equipe = 'brancas';

  grafo.getNo('(1, 7)')!.ocupado = true;
  grafo.getNo('(1, 7)')!.peca = 'escudo';
  grafo.getNo('(1, 7)')!.equipe = 'brancas';

  grafo.getNo('(3, 5)')!.ocupado = true;
  grafo.getNo('(3, 5)')!.peca = 'escudo';
  grafo.getNo('(3, 5)')!.equipe = 'brancas';

  grafo.getNo('(0, -7)')!.ocupado = true;
  grafo.getNo('(0, -7)')!.peca = 'escudo';
  grafo.getNo('(0, -7)')!.equipe = 'pretas';

  grafo.getNo('(-1, -7)')!.ocupado = true;
  grafo.getNo('(-1, -7)')!.peca = 'escudo';
  grafo.getNo('(-1, -7)')!.equipe = 'pretas';

  grafo.getNo('(1, -8)')!.ocupado = true;
  grafo.getNo('(1, -8)')!.peca = 'escudo';
  grafo.getNo('(1, -8)')!.equipe = 'pretas';

  grafo.getNo('(3, -8)')!.ocupado = true;
  grafo.getNo('(3, -8)')!.peca = 'escudo';
  grafo.getNo('(3, -8)')!.equipe = 'pretas';

  grafo.getNo('(-3, -5)')!.ocupado = true;
  grafo.getNo('(-3, -5)')!.peca = 'escudo';
  grafo.getNo('(-3, -5)')!.equipe = 'pretas';
}

void setupTabuleiroDidatico(Grafo grafo) {
  grafo.getNo('(0, -1)')!.ocupado = true;
  grafo.getNo('(0, -1)')!.peca = 'sentinela';
  grafo.getNo('(0, -1)')!.equipe = 'brancas';

  grafo.getNo('(2, -6)')!.ocupado = true;
  grafo.getNo('(2, -6)')!.peca = 'sentinela';
  grafo.getNo('(2, -6)')!.equipe = 'pretas';

  grafo.getNo('(2, -4)')!.ocupado = true;
  grafo.getNo('(2, -4)')!.peca = 'conjurador';
  grafo.getNo('(2, -4)')!.equipe = 'brancas';

  grafo.getNo('(-2, 0)')!.ocupado = true;
  grafo.getNo('(-2, 0)')!.peca = 'conjurador';
  grafo.getNo('(-2, 0)')!.equipe = 'brancas';

  grafo.getNo('(4, -6)')!.ocupado = true;
  grafo.getNo('(4, -6)')!.peca = 'conjurador';
  grafo.getNo('(4, -6)')!.equipe = 'pretas';

  grafo.getNo('(-2, -2)')!.ocupado = true;
  grafo.getNo('(-2, -2)')!.peca = 'conjurador';
  grafo.getNo('(-2, -2)')!.equipe = 'pretas';

  grafo.getNo('(0, -2)')!.ocupado = true;
  grafo.getNo('(0, -2)')!.peca = 'atacante';
  grafo.getNo('(0, -2)')!.equipe = 'brancas';

  grafo.getNo('(0, -4)')!.ocupado = true;
  grafo.getNo('(0, -4)')!.peca = 'atacante';
  grafo.getNo('(0, -4)')!.equipe = 'pretas';

  grafo.getNo('(1, -1)')!.ocupado = true;
  grafo.getNo('(1, -1)')!.peca = 'escudo';
  grafo.getNo('(1, -1)')!.equipe = 'brancas';

  grafo.getNo('(2, -1)')!.ocupado = true;
  grafo.getNo('(2, -1)')!.peca = 'escudo';
  grafo.getNo('(2, -1)')!.equipe = 'brancas';

  grafo.getNo('(-2, 1)')!.ocupado = true;
  grafo.getNo('(-2, 1)')!.peca = 'escudo';
  grafo.getNo('(-2, 1)')!.equipe = 'brancas';

  grafo.getNo('(-1, 2)')!.ocupado = true;
  grafo.getNo('(-1, 2)')!.peca = 'escudo';
  grafo.getNo('(-1, 2)')!.equipe = 'brancas';

  grafo.getNo('(1, 1)')!.ocupado = true;
  grafo.getNo('(1, 1)')!.peca = 'escudo';
  grafo.getNo('(1, 1)')!.equipe = 'brancas';

  grafo.getNo('(2, -7)')!.ocupado = true;
  grafo.getNo('(2, -7)')!.peca = 'escudo';
  grafo.getNo('(2, -7)')!.equipe = 'pretas';

  grafo.getNo('(0, -5)')!.ocupado = true;
  grafo.getNo('(0, -5)')!.peca = 'escudo';
  grafo.getNo('(0, -5)')!.equipe = 'pretas';

  grafo.getNo('(-3, -4)')!.ocupado = true;
  grafo.getNo('(-3, -4)')!.peca = 'escudo';
  grafo.getNo('(-3, -4)')!.equipe = 'pretas';

  grafo.getNo('(1, -4)')!.ocupado = true;
  grafo.getNo('(1, -4)')!.peca = 'escudo';
  grafo.getNo('(1, -4)')!.equipe = 'pretas';

  grafo.getNo('(3, -6)')!.ocupado = true;
  grafo.getNo('(3, -6)')!.peca = 'escudo';
  grafo.getNo('(3, -6)')!.equipe = 'pretas';
}
