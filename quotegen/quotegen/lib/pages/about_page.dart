import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          
          title: RichText(
            text: TextSpan(
              text: 'QUOTE ',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Aesthetic'),
              children: [
                TextSpan(
                  text: 'GEN',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Aesthetic'),
                )
              ],
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          child: Text("Developed by AIDA."),
        ),
    );
  }
}