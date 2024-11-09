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
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: const Center(child: Text("Instruções")),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.emoji_events,
                color: Colors.amber,
                size: 50,
              ),
              SizedBox(height: 10),
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
        );
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
