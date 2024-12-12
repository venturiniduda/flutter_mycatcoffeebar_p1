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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(45.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/images/logo.png'),
              Text(
                'My Cat',
                style: GoogleFonts.holtwoodOneSc(
                    fontSize: 50, color: Colors.brown.shade900),
              ),
              Text(
                'Coffee Bar',
                style: GoogleFonts.reenieBeanie(
                    fontSize: 30, color: Colors.brown.shade900),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.pets,
                      size: 30.0,
                      color: Colors.brown.shade900,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Iniciar',
                      style: GoogleFonts.holtwoodOneSc(
                          fontSize: 15, color: Colors.brown.shade900),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
