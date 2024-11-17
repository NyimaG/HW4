import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hw4/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersive); //gets rid of top & bottom bars
    Future.delayed(const Duration(seconds: 3), () {
      //takes you to home screen after 3 seconds
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const MyApp()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, //brings back bars
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.pink, Colors.blue],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to ChatBoard",
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
                Icon(
                  Icons.message,
                  size: 80,
                  color: Colors.white,
                ),
              ],
            )));
  }
}
