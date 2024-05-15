import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/aida.jpg'), fit: BoxFit.cover),
        ),
        child: Container(
          width: screenWidth,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(colors: [
          //     Colors.green[800]!.withOpacity(0.6),
          //     Colors.yellow.withOpacity(0.4),
          //     Colors.red[800]!.withOpacity(0.6)
          //   ]),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // Text('Speak up, let us do the rest! alɔ Do mɛ tɔ : your assistant in Fon and Yoruba to simplify daily life',
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 20.0,
                    //     ),
                    //     textAlign: TextAlign.center),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0, top: 15),
                child: MaterialButton(
                  
                  onPressed: () {
                    // go to list device page
                    Navigator.pushNamed(context, "/homepage");
                  },
                  
                  child: const Text(
                    'Commencez',
                    style: TextStyle(fontSize: 25,),
                  ),
                  color: Color.fromARGB(255, 97, 124, 244),
                  minWidth: screenWidth - 64,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(32.0),
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