import 'package:dispute_of_sovereigns/constants/colors.dart';
import 'package:dispute_of_sovereigns/models/grafos.dart';
import 'package:flutter/material.dart';

class VisualizaGrafo extends StatefulWidget {
  const VisualizaGrafo({super.key, required this.grafo});

  final Grafo grafo;

  @override
  State<VisualizaGrafo> createState() => _VisualizaGrafoState();
}

class _VisualizaGrafoState extends State<VisualizaGrafo> {
  late Grafo grafo;

  @override
  void initState() {
    grafo = widget.grafo;
    super.initState();
  }

  Widget cardNo(No no, List<No> vizinhos) {
    return Card(
      color: no.ocupado ? Colors.grey[400] : Colors.grey[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nó: ${no.id}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Visível: ${no.visivel == false ? no.equipe == 'brancas' ? 'Sim' : 'Não' : no.visivel ? 'Sim' : 'Não'}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.darkgrey,
                  ),
                ),
                Chip(
                  label: Text(no.ocupado ? 'Com Peça' : 'Sem Peça'),
                  backgroundColor: no.ocupado ? Colors.red[700] : Colors.green,
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            if (no.ocupado)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Peça: ${no.peca}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.darkdblue,
                      ),
                    ),
                    Chip(
                      label: Text(no.equipe == 'brancas'
                          ? 'Equipe branca'
                          : 'Equipe preta'),
                      backgroundColor: no.equipe == 'brancas'
                          ? Colors.grey[300]
                          : AppColors.oceanblue,
                      labelStyle: TextStyle(
                          color: no.equipe == 'brancas'
                              ? AppColors.oceanblue
                              : Colors.white),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            const Divider(
              color: AppColors.darkgrey,
            ),
            const Text(
              'Vizinhos:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: vizinhos.map((vizinho) {
                return Chip(
                  label: Text(vizinho.id),
                  backgroundColor:
                      vizinho.ocupado ? AppColors.darkgrey : Colors.grey[300],
                  labelStyle: TextStyle(
                      color: vizinho.ocupado ? Colors.white : Colors.black),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(
      //     title: Padding(
      //       padding: const EdgeInsets.only(bottom: 10),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           // Quantidade de nós e arestas:
      //           Text(
      //             'Quantidade de nós: ${grafo.qntdNos}',
      //             style: const TextStyle(
      //                 fontSize: 18, color: AppColors.lightlbluegrey),
      //           ),
      //           const SizedBox(height: 8),
      //           Text(
      //             'Quantidade de arestas: ${grafo.qntdArestas}',
      //             style: const TextStyle(
      //                 fontSize: 18, color: AppColors.lightlbluegrey),
      //           ),
      //         ],
      //       ),
      //     ),
      //     backgroundColor: AppColors.darkblue,
      //   ),
      backgroundColor: AppColors.dark,
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: grafo.adjacencias.length,
        itemBuilder: (context, index) {
          final entry = grafo.adjacencias.entries.elementAt(index);
          final no = entry.key;
          final vizinhos = entry.value;

          return cardNo(no, vizinhos);
        },
      ),
    );
  }
}
