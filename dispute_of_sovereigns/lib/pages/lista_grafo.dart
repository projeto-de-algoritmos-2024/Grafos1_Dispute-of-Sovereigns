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

  Widget CardNo(No no, List<No> vizinhos) {
    return Card(
      color: no.ocupado ? Colors.red[50] : Colors.green[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                  'Movendo: ${no.mover}',
                  style: const TextStyle(fontSize: 16),
                ),
                Chip(
                  label: Text(no.ocupado ? 'Ocupado' : 'Livre'),
                  backgroundColor: no.ocupado ? Colors.red : Colors.green,
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            if (no.ocupado)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Peça: ${no.peca}',
                      style: const TextStyle(
                          fontSize: 16, color: Colors.blueAccent),
                    ),
                    Text(
                      'Equipe: ${no.equipe}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: no.equipe == 'Azul' ? Colors.blue : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            const Divider(),
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
                      vizinho.ocupado ? Colors.red[100] : Colors.green[100],
                  labelStyle: TextStyle(
                      color: vizinho.ocupado ? Colors.red : Colors.green),
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
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: grafo.adjacencias.length,
        itemBuilder: (context, index) {
          final entry = grafo.adjacencias.entries.elementAt(index);
          final no = entry.key;
          final vizinhos = entry.value;

          return CardNo(no, vizinhos);
        },
      ),
    );
  }
}
