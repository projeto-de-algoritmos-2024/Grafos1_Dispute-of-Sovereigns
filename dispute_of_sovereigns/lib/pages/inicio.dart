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
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Padding(padding: const EdgeInsets.only(left: 300, right: 300), child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: const Center(child: Text("Instruções")),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Introdução:", style: TextStyle(
              fontWeight: FontWeight.bold),),
              const Text("O Disputa dos Soberanos é um jogo de tabuleiro entre dois jogadores, com 270 casas dispostas em um tabuleiro hexagonal, alternando cores entre claro e escuro. Cada jogador começa com 9 peças: 1 Sentinela; 4 atacantes, 2 escudos e 2 conjuradores, sendo que as peças dos adversário ficam ocultas para o jogador."),
              const SizedBox(height: 15),
              const Text("Movimentos das peças:", style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
              const Text("É permitido movimentar a peça para uma casa vazia ou ocupada por uma peça adversária. Ao movimentar por uma casa ocupada por uma peça adversária, essa peça é eliminada."),
              const SizedBox(height: 15),
              const Text("Peças:", style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
              Column(children: [
                Row(children: [
                  Padding(padding:  EdgeInsets.only(right: 10), child: CircleAvatar(child: Image.asset("assets/icons/visao.png", width: 25, height: 25,),),),
                  const Text("Sentinela: move-se uma casa em qualquer direção em um raio de 1 casa.")
                ],),
                Row(children: [
                  Padding(padding:  EdgeInsets.only(right: 10), child: CircleAvatar(child: Image.asset("assets/icons/assassino.png", width: 25, height: 25,),),),
                  const Text("Atacante: move-se em qualquer direção em um raio de 2 casas.")
                ],),
                Row(children: [
                  Padding(padding:  EdgeInsets.only(right: 10), child: CircleAvatar(child: Image.asset("assets/icons/escudo.png", width: 25, height: 25,),),),
                  const Text("Escudo: move-se uma casa em qualquer direção em um raio de 1 casa, exceto nas casas escuras.")
                ],),
                Row(children: [
                  Padding(padding:  EdgeInsets.only(right: 10), child: CircleAvatar(child: Image.asset("assets/icons/feiticeiro2.png", width: 25, height: 25,),),),
                  const Text("Conjurador: move-se uma casa em qualquer direção em um raio de 2 casas, exceto nas casas claras.")
                ],),
              ],),
              const SizedBox(height: 15),
              const Text("Função Especial:", style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
              const Text("Ao mover qualquer peça da equipe, a Sentinela dispara um pulso que revela as peças adversárias em um raio de 6 casas. Dica: O ideal é movimentar a sentinela junto com a equipe para que possa dar direcionamento onde as peças adversárias estão."),
              const SizedBox(height: 15),
              const Text("Objetivo:", style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
              const Text("O objetivo é eliminar a sentinela do time adversário ou percorrer o tabuleiro até chegar no ultima casa da base inimiga."),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Fechar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ))
         ;
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
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  "Frase daora...",
                  style: TextStyle(
                    fontSize: width >= 600 ? 22 : 16,
                    fontWeight: FontWeight.w200,
                    fontStyle: FontStyle.italic,
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.light,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
