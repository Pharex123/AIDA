import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quotegen/pages/ask_page.dart';
import 'package:quotegen/pages/audio_page.dart';
import 'package:quotegen/pages/camera_page.dart';
import 'package:quotegen/pages/settings_page.dart';
import 'package:quotegen/pages/voice_page.dart';
import 'package:quotegen/widgets/custom_drawer.dart';


class HomePage extends StatefulWidget {
 HomePage({super.key});


 @override
 State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
 // this keeps track of the current page to display
 int _selectedIndex = 0;


 // this method update the new selected index
 void _navigationBottomBar(int index) {
   setState(() {
     _selectedIndex = index;
   });
 }


 final List _pages = [
   // homepage
  //  HomePage(),

  //  VoicePage(),
   AudioPage(),

   // profile page
   
   CameraPage(),

   AskPage(),

   // settings page
 ];


 @override
 Widget build(BuildContext context) {
   return Scaffold(
    drawer: const CustomDrawer(),
     appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                if (FocusScope.of(context).hasFocus) {
                  FocusScope.of(context).unfocus();
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  Iconsax.setting_2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
          leading: InkWell(
            onTap: () {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
              }
              scaffoldKey.currentState?.openDrawer();
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
              }
            },
            child: Icon(
              Iconsax.element_plus,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: RichText(
            text: TextSpan(
              text: 'AI ',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Aesthetic'),
              children: [
                TextSpan(
                  text: 'ASSISTANT',
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
      
     body: _pages[_selectedIndex],
     bottomNavigationBar: BottomNavigationBar(
         currentIndex: _selectedIndex,
         onTap: _navigationBottomBar,
         items: [
           // home
          //  BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),


           // profile
           BottomNavigationBarItem(icon: Icon(Iconsax.microphone), label: "Record"),
           BottomNavigationBarItem(icon: Icon(Iconsax.camera), label: "Camera"),


           BottomNavigationBarItem(icon: Icon(Iconsax.message_question), label: "Ask"),


          
         ]),
   );
 }
}
