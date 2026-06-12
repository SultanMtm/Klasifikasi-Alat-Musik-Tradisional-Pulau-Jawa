import 'package:alatmusik/information_page.dart';
import 'package:alatmusik/informationeng_page.dart';
import 'package:alatmusik/prediction_page.dart';
import 'package:alatmusik/predictioneng_page.dart';
import 'package:alatmusik/welcome_page.dart';
import 'package:alatmusik/welcomeeng_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Widget currentPage = WelcomePage();

  changePage(int selected) {
    if (selected == 1) {
      currentPage = WelcomePage();
    } else if (selected == 2) {
      currentPage = PredictionPage();
    } else if (selected == 3) {
      currentPage = InformationPage();
    } else if (selected == 4) {
      currentPage = WelcomeengPage();
    } else if (selected == 5) {
      currentPage = PredictionengPage();
    } else {
      currentPage = InformationengPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 30),
                Text(
                  "Bahasa Indonesia",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                ListTile(
                  onTap: () {
                    setState(() {
                      changePage(1);
                    });
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.home),
                  title: TextWidget(text: "Beranda"),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      changePage(2);
                    });
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.search),
                  title: TextWidget(text: "Pindai Gambar"),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      changePage(3);
                    });
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.info_outline_rounded),
                  title: TextWidget(text: "Deskripsi"),
                ),
                SizedBox(height: 30),
                Text(
                  "English Language",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                ListTile(
                  onTap: () {
                    setState(() {
                      changePage(4);
                    });
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.home),
                  title: TextWidget(text: "Home"),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      changePage(5);
                    });
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.search),
                  title: TextWidget(text: "Scan Image"),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      changePage(6);
                    });
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.info_outline_rounded),
                  title: TextWidget(text: "Description"),
                )
              ],
            ),
          ),
        ),
        body: currentPage);
  }
}

class TextWidget extends StatelessWidget {
  final String text;
  const TextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 24),
    );
  }
}
