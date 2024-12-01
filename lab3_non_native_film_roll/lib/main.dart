import 'package:flutter/material.dart';
import 'RollsListScreen.dart';
import 'SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins', // Replace with the font family you set up in pubspec.yaml
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB4B4B8), // Custom AppBar color
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEBE3D5), // Custom button background color
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAB886D),
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
            "Film Roll Photo Journal",
            style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w400,
       ),
      ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Navigate to list screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ListScreen()),
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Camera Body
              Container(
                width: 280,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color(0xFFAB886D),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
              ),
              // Lens (Circular part)
              Positioned(
                top: 15,
                child: Container(
                  width: 60,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.camera,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
              // Flash (Small rectangle)
              Positioned(
                top: 15,
                right: 25,
                child: Container(
                  width: 30,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              // Text (See Rolls)
              Positioned(
                bottom: 10,
                child: const Text(
                  "See Rolls",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
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
