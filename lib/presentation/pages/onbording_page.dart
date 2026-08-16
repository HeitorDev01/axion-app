import 'package:app_axion/presentation/pages/car_list_screen.dart';
import 'package:app_axion/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OnbordingPage extends StatelessWidget {
  const OnbordingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // Mesmo preto do resto do app: a foto de cima termina em preto, então
       // não fica emenda entre a imagem e o fundo da tela
       backgroundColor: kAppBackground,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/onboarding.png'),
                  fit: BoxFit.cover,
                ),
              )
            ),
          ),
          Expanded(
            // Em telas baixas o texto + botão não cabem nesta metade e a
            // Column estourava. O scroll só entra em ação quando falta espaço:
            // com altura sobrando, o minHeight mantém tudo centralizado.
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Bem-vindo ao Axion, carros premium! \nEntre na luxuria',
                    textAlign: TextAlign.center,
                     style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32, 
                      fontWeight: FontWeight.bold)
                      ),
                  SizedBox(height: 15),
                  Text(
                    'Aluguel diário de carros de luxo premium. \nExperimente o luxo por um preço mais baixo.',  
                    textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                          ),
                        ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 320,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => CarListScreen()), (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                    child: 
                    const Text(
                      'Começar',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}