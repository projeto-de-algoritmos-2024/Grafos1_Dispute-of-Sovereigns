import 'package:dispute_of_sovereigns/constants/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void modalInstrucao(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Padding(
            padding: const EdgeInsets.only(left: 300, right: 300),
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              title: const Center(child: Text("Instruções")),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Introdução:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Text(
                      "O Disputa dos Soberanos é um jogo de tabuleiro, onde o jogador joga contra a \"CPU\". O tabuleiro conta com 270 casas dispostas em um tabuleiro hexagonal, com as casas alternando cores claras e escuras. Cada jogador começa com 9 peças: 1 Sentinela, 1 Atacante, 5 Escudos e 2 Conjuradores. Também vale ressaltar que as peças dos adversário ficam ocultas para o jogador.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Movimentos das peças:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Text(
                      "É permitido movimentar uma peça para uma casa que esteja vazia ou que esteja ocupada por uma peça adversária. Ao movimentar para uma casa ocupada por uma peça adversária, a peça do adversário é eliminada.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Peças:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 4),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    "assets/icons/visao.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                              const Text(
                                "Sentinela: move-se para uma casa em qualquer direção, em um raio de 1 casa.",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 4),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    "assets/icons/assassino.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                              const Text(
                                "Atacante: move-se para uma casa em qualquer direção, em um raio de 2 casas.",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 4),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    "assets/icons/escudo.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                              const Text(
                                "Escudo: move-se para uma casa em qualquer direção, em um raio de 1 casa, com exceção das casas escuras.",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 4),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    "assets/icons/feiticeiro2.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                              const Text(
                                "Conjurador: move-se para uma casa em qualquer direção, em um raio de 2 casas, com exceção das casas claras.",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Função Especial:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Text(
                      "Ao mover qualquer peça da equipe, a Sentinela dispara um pulso que revela as peças adversárias em um raio de 6 casas.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Dica:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Text(
                      "O ideal é movimentar a Sentinela junto com o restante das peças. Pois dessa forma é possível aproveitar da melhor forma possível a habilidade especial de revelação da Sentinela.",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Objetivo:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Text(
                      "É possível vencer o jogo de duas maneiras:",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: Icon(Icons.circle,
                                      size: 8, color: AppColors.dark),
                                ),
                                Text(
                                  "A primeira, é eliminando a Sentinela do time adversário.",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: Icon(Icons.circle,
                                      size: 8, color: AppColors.dark),
                                ),
                                Text(
                                  "A segunda, é percorrendo o tabuleiro levando a Sentinela até a casa da base inimiga.",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Fechar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Padding(
        padding: EdgeInsets.only(
          left: width >= 600 ? 300 : 35,
          right: width >= 600 ? 300 : 35,
          top: 50,
          bottom: 80,
        ),
        child: Card(
          color: AppColors.darkblue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "Dispute of Sovereigns",
                      style: TextStyle(
                        fontSize: width >= 600 ? 52 : 32,
                        fontWeight: FontWeight.w900,
                        color: AppColors.light,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: width >= 600 ? 64 : 24),
                    child: const Divider(
                      color: AppColors.dark,
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(Size(370, 100)),
                  backgroundColor: WidgetStatePropertyAll(
                    AppColors.darkgreen,
                  ),
                  elevation: WidgetStatePropertyAll(2),
                  foregroundColor: WidgetStatePropertyAll(
                    AppColors.light,
                  ),
                  shape: WidgetStatePropertyAll(
                    ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                child: const Text("Jogar", style: TextStyle(fontSize: 24)),
                onPressed: () {
                  Navigator.pushNamed(context, '/jogo');
                },
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: width >= 600 ? 64 : 24, bottom: 196),
                child: ElevatedButton(
                  style: const ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(370, 100)),
                    backgroundColor: WidgetStatePropertyAll(
                      AppColors.bluegrey,
                    ),
                    elevation: WidgetStatePropertyAll(2),
                    foregroundColor: WidgetStatePropertyAll(
                      AppColors.light,
                    ),
                    shape: WidgetStatePropertyAll(
                      ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                  child:
                      const Text("Instruções", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    modalInstrucao(context);
                  },
                ),
              ),
              //   Padding(
              //     padding: const EdgeInsets.only(bottom: 18, left: 20, right: 20),
              //     child: Text(
              //       "Muitas vezes é a mente mais afiada que vence a guerra, não a lâmina mais afiada.",
              //       style: TextStyle(
              //         fontSize: width >= 600 ? 22 : 16,
              //         fontWeight: FontWeight.w200,
              //         fontStyle: FontStyle.italic,
              //         overflow: TextOverflow.ellipsis,
              //         color: AppColors.light,
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
