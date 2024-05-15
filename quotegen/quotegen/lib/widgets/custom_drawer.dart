import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/about_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            alignment: Alignment(1, 1),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Iconsax.close_circle, size: 25,),
                ),
          ),
          DrawerHeader(
            child: Center(
              child: Image.asset('assets/images/AIDA.jpg'),
            ),
          ),
          ListTile(
            leading: const Icon(Iconsax.info_circle),
            title: Text(
              "About",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Nexa'),
            ),
            subtitle: Text(
              "About this project",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontFamily: 'NexaLight',
              ),
            ),
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ),
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'v1.0.0',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                      fontFamily: 'Nexa'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
