import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Text(
                'HIP',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                  'SPOT',
                  style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic)
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: const Center(

        ),
      ),
    );
  }
}