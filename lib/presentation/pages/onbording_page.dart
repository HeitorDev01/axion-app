import 'package:app_axion/presentation/pages/car_list_screen.dart';
import 'package:flutter/material.dart';

class OnbordingPage extends StatelessWidget {
  const OnbordingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor:Color(0xff2c2b34),
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
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CarListScreen()));
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
          )
        ],
      ),
    );
  }
}