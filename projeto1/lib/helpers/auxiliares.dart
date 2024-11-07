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
import 'package:projeto1/models/grafos.dart';

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
