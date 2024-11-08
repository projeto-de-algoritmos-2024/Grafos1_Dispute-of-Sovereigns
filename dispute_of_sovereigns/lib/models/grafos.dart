import 'dart:collection';
import 'package:flutter/foundation.dart';

class No {
  // Identificador do no:
  final String id;

  // Posicao do no no tabuleiro (q, r):
  final Map<String, int> posicao;

  // Indica se o no esta ocupado:
  bool ocupado;

  // Indica a peça que esta no nó:
  String peca;

  // Indica a "equipe" da peça que está no nó:
  String equipe;

  // Indica se a peça está num estado de se movimentar:
  bool mover = false;

  // Indica se a casa é visivel:
  bool visivel = false;

  // Construtor:
  No(this.id, this.posicao, this.ocupado, this.peca, this.equipe, this.mover,
      this.visivel);
}

// Classe para representar um Grafo:
class Grafo {
  // "Lista" de adjacências:
  Map<No, List<No>> adjacencias = {};

  // Quantidade de nós no grafo:
  int qntdNos = 0;

  int qntdArestas = 0;

  /* 
   * Adicionar um novo nó no grafo.
   * 
   * Parâmetros:
   * - id: identificador do nó;
   * - posicao: posição do nó no tabuleiro (q, r);
   * - ocupado: se o nó está ocupado;
   * - peca: peça que o nó contém;
   * - equipe: equipe da peça que o nó contém;
   * - mover: se a peça está num estado de se movimentar.
   */
  void addNo(String id, Map<String, int> posicao, bool ocupado, String peca,
      String equipe, bool mover, bool visivel) {
    // Cria um novo nó:
    No novoNo = No(id, posicao, ocupado, peca, equipe, mover, visivel);

    // Verifica se o nó já existe:
    if (adjacencias.containsKey(novoNo)) {
      return;
    } else {
      // Adiciona o novo nó ao grafo:
      adjacencias[novoNo] = [];
    }

    // Incrementa a quantidade de nós no grafo:
    qntdNos++;
  }

  /* 
   * Adicionar uma nova aresta no grafo.
   * 
   * Parâmetros:
   * - u: nó vizinho de v;
   * - v: nó vizinho de u.
   */
  void addAresta(No u, No v) {
    // Verifica se a aresta já existe:
    if (adjacencias[u]!.contains(v) || adjacencias[v]!.contains(u)) {
      return;
    } else {
      // Adiciona a aresta na Lista de adjacências dos dois Nós:
      adjacencias[u]!.add(v);
      adjacencias[v]!.add(u);
    }

    // Incrementa a quantidade de arestas no grafo:
    qntdArestas++;
  }

  /* 
   * Retorna um Nó do Grafo pelo seu ID.
   * 
   * Parâmetros:
   * - id: identificador do nó.
   * 
   * Retorno:
   * - Nó do Grafo com o ID especificado | null.
   */
  No? getNo(String id) {
    // Procura o nó pelo ID na Lista de adjacências:
    for (var no in adjacencias.keys) {
      // Se encontrar o nó, retorna ele:
      if (no.id == id) {
        return no;
      }
    }

    // Caso não encontre, retorna null:
    return null;
  }

  /* 
   * Função para realizar uma busca em largura (BFS) no grafo.
   * 
   * Parâmetros:
   * - inicio: nó de início da busca.
   * 
   * Retorno:
   * - Lista com ID's para montar a árvore de nós pais de cada nó visitado.
   */
  Map<String, String> bfs(No inicio) {
    // Lista para armazenar os pais de cada nó visitado:
    Map<String, String> pai = {};

    // Marcar o nó inicial como pai dele mesmo (Raiz da árvore):
    pai[inicio.id] = inicio.id;

    // Lista para marcar os nós visitados:
    List<String> visitados = [];

    // Adicionar o nó inicial na lista de visitados:
    visitados.add(inicio.id);

    // Fila para controlar os nós cujos vizinhos serão visitados:
    Queue<No> fila = Queue<No>();

    // Adicionar o nó inicial na Fila:
    fila.add(inicio);

    // Enquanto a Fila não estiver vazia continua a busca:
    while (fila.isNotEmpty) {
      // Remover o nó da frente da Fila:
      No atual = fila.removeFirst();

      // Obter os vizinhos do nó atual:
      List<No>? vizinhos = adjacencias[atual];

      // Visitar cada vizinho do nó atual:
      for (No vizinho in vizinhos!) {
        // Verifica se o vizinho não está na Lista de pais, não está na Lista de visitados e se não está ocupado:
        if (!pai.containsKey(vizinho.id) &&
            !visitados.contains(vizinho.id) &&
            !vizinho.ocupado) {
          // Adicionar o vizinho na Lista de pais como filho do nó atual:
          pai[vizinho.id] = atual.id;

          // Adicionar o vizinho na Lista de visitados:
          visitados.add(vizinho.id);

          // Adicionar o vizinho na Fila para visitar seus vizinhos:
          fila.add(vizinho);
        }
      }
    }

    // Retornar a Lista de pais:
    return pai;
  }

  /* 
   * Função para realizar uma busca em largura (BFS) no grafo, porém, até determinada profundidade.
   * 
   * Parâmetros:
   * - inicio: nó de início da busca.
   * - profundidade: profundidade máxima da busca (até que grau de vizinhança irá).
   * 
   * Retorno:
   * - Lista com ID's para montar a árvore de nós pais de cada nó visitado.
   */
  Map<String, String> bfsProfundidade(No inicio, int profundidade) {
    // Lista para armazenar os pais de cada nó visitado:
    Map<String, String> pai = {};

    // Lista para marcar os nós visitados:
    List<String> visitados = [];

    /* 
     * Aqui não marcamos o nó inicial como pai dele 
     * mesmo, pois essa função será para verificar o raio de 
     * movimentação das peças, e ela não irá se mover para 
     * onde já está. 
    */

    // Adicionar o nó inicial na lista de visitados:
    visitados.add(inicio.id);

    // Fila para controlar os nós cujos vizinhos serão visitados: (Aqui há a diferença, de que também irá armazenar a "distância" que está do nó inicial)
    Queue<Map<No, int>> fila = Queue<Map<No, int>>();

    // Adicionar o nó inicial na Fila (com profundidade 0, pois está há 0 de distância dele mesmo):
    fila.add({inicio: 0});

    // Enquanto a fila não estiver vazia continua a busca:
    while (fila.isNotEmpty) {
      // Remover o nó da frente da Fila:
      Map<No, int> u = fila.removeFirst();

      // Nó atual e a profundidade dele:
      No atual = u.keys.first;
      int profundidadeAtual = u.values.first;

      // Se a profundidade do Nó atual for maior ou igual a profundidade máxima, para a busca:
      if (profundidadeAtual >= profundidade) {
        break;
      }

      // Obter os vizinhos do nó atual:
      List<No>? vizinhos = adjacencias[atual];

      // Visitar cada vizinho do nó atual:
      for (No vizinho in vizinhos!) {
        // Verifica se o vizinho não está na Lista de pais e se não está na Lista de visitados:
        if (!pai.containsKey(vizinho.id) && !visitados.contains(vizinho.id)) {
          // Adicionar o vizinho na Lista de visitados:
          visitados.add(vizinho.id);

          // Adicionar o vizinho na Fila para visitar seus vizinhos (com uma profundidade + 1):
          fila.add({vizinho: profundidadeAtual + 1});

          // Verifica se o vizinho não está ocupado ou se a equipe é diferente, pois se não está ocupado, nice, mas se está ocupado por uma peça de outra equipe, ele ainda pode se mover até lá (capturar):
          if (!vizinho.ocupado || (vizinho.equipe != inicio.equipe)) {
            // Adicionar o vizinho na Lista de pais como filho do nó atual:
            pai[vizinho.id] = atual.id;
          }
        }
      }
    }

    // Retornar a Lista de pais:
    return pai;
  }

  List<No> bfsPulso(No sentinela) {
    // // Percorrer todos nós e settar como visiveis a cada 2 segundos com Timer.periodic:
    // List<No> nos = grafo.adjacencias.keys.toList();

    // Timer.periodic(Duration(milliseconds: 50), (timer) {
    //   No no = nos.isNotEmpty ? nos.removeAt(0) : nos[0];
    //   setState(() {
    // no.visivel = true;
    // if (nos.length == 1) {
    //   timer.cancel();
    // }
    //   });
    // });

    // Lista para armazenar os Nós na ordem que foram visitados:
    List<No> ordem = [];

    // Adicionar o nó da peça Sentinela na Lista ordem:
    ordem.add(sentinela);

    // Lista para marcar os nós visitados:
    List<String> visitados = [];

    // Adicionar o nó da peça Sentinela na lista de visitados:
    visitados.add(sentinela.id);

    // Fila para controlar os nós cujos vizinhos serão visitados:
    Queue<Map<No, int>> fila = Queue<Map<No, int>>();

    // Adicionar o nó da peça Sentinela na Fila:
    fila.add({sentinela: 0});

    // Enquanto a Fila não estiver vazia continua a busca:
    while (fila.isNotEmpty) {
      // Remover o nó da frente da Fila:
      Map<No, int> u = fila.removeFirst();

      // Nó atual e a profundidade dele:
      No atual = u.keys.first;
      int profundidadeAtual = u.values.first;

      // Se a profundidade do Nó atual for maior ou igual a profundidade máxima, para a busca:
      if (profundidadeAtual >= 6) {
        break;
      }

      // Obter os vizinhos do nó atual:
      List<No>? vizinhos = adjacencias[atual];

      // Visitar cada vizinho do nó atual:
      for (No vizinho in vizinhos!) {
        // Verifica se o vizinho não está na Lista de visitados:
        if (!visitados.contains(vizinho.id)) {
          // Adicionar o vizinho na Lista ordem:
          ordem.add(vizinho);

          // Adicionar o vizinho na Lista de visitados:
          visitados.add(vizinho.id);

          // Adicionar o vizinho na Fila para visitar seus vizinhos:
          fila.add({vizinho: profundidadeAtual + 1});
        }
      }
    }

    // Retornar a Lista com a ordem dos nós visitados:
    return ordem;
  }

  /* 
   * Retorna uma lista com os nós do menor caminho de um nó a outro, a partir da Lista de nós pais formada por uma BFS.
   * 
   * Parâmetros:
   * - pai: "Lista" de nós pais obtida pela BFS.
   * - inicio: nó de inicio do caminho.
   * - fim: nó de fim do caminho.
   * 
   * Retorno:
   * - Lista com ID's do menor caminho do nó inicio ao nó fim.
   */
  List<String> montarMenorCaminho(Map<String, String> pai, No inicio, No fim) {
    // Lista para armazenar o caminho:
    List<String> caminho = [];

    // Atual recebe o ID do nó final:
    String atual = fim.id;

    // Repete enquanto o ID atual for diferente do ID do nó inicial:
    while (atual != inicio.id) {
      // Adiciona o ID atual na Lista de caminho:
      caminho.add(atual);

      // Atual recebe o ID do pai do nó atual:
      atual = pai[atual]!;
    }

    // Adiciona o ID do nó inicial na Lista de caminho:
    caminho.add(inicio.id);

    // Inverte a Lista de caminho para ficar na ordem correta:
    caminho = caminho.reversed.toList();

    // Retorna a Lista de caminho:
    return caminho;
  }

  /* 
   * Printa os Nós do Grafo e suas adjacências.
   * 
   */
  void printGrafo() {
    // Percorre os nós da Lista de adjacências:
    for (var no in adjacencias.keys) {
      // Printa o ID do Nó e o ID dos seus Vizinhos no console:
      if (kDebugMode) {
        print('${no.id} -> ${adjacencias[no]!.map((e) => e.id).toList()} \n');
      }
    }
  }

  /* 
   * Printa os Vizinhos de um Nó.
   * 
   * Parâmetros:
   * - no: Nó do qual se deseja printar os vizinhos.
   */
  void printVizinhos(No no) {
    if (kDebugMode) {
      print('Vizinhos de ${no.id}:');
    }

    for (var adj in adjacencias[no]!) {
      if (kDebugMode) {
        print('  -> ${adj.id}');
      }
    }
  }
}
