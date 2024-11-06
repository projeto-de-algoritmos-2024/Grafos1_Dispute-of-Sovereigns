import 'dart:collection';

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

  // Construtor:
  No(this.id, this.posicao, this.ocupado, this.peca, this.equipe,
   this.mover);
}

// Classe para representar um Grafo:
class Grafo {
  // "Lista" de adjacências:
  Map<No, List<No>> adjacencias = {};

  // Quantidade de nós no grafo:
  int qntdNos = 0;

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
      String equipe, bool mover) {
    // Cria um novo nó:
    No novoNo = No(id, posicao, ocupado, peca, equipe, mover);

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
}

