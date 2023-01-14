import 'package:flutter/material.dart';
import 'package:hipspot/sliderightroute.dart';
import 'package:hipspot/webview.dart';
import 'main.dart';

class MyHomaPage extends StatelessWidget {
  const MyHomaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text(
              'HIP',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
              ),
            ),
            Text(
                'SPOT',
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontSize: 32,
                )
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    '어떤 카페를 찾으시나요?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    '건너뛰기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff999999),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          SlideRightRoute(page: const Webview())
                      );
                    },
                    child: Ink(
                      width: double.infinity,
                      color: Colors.pink,
                      child: const Text(
                        '  GO ->',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}