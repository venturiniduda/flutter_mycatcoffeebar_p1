import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(45.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // adicionar uma imagem aqui antes do nome
              Image.asset('lib/images/logo.png'),
              Text(
                'My Cat',
                style: GoogleFonts.holtwoodOneSc(
                  fontSize: 50,
                ),
              ),
              Text(
                'Coffee Bar',
                style: GoogleFonts.reenieBeanie(
                  fontSize: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
                icon: const Icon(Icons.arrow_forward, size: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
