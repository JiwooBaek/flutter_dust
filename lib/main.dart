import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('현재 위치 미세먼지', style: TextStyle(fontSize: 30),),
            Card(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('얼굴사진'),
                      Text('80'),
                      Text('보통'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('얼굴사진'),
                      Text('80'),
                      Text('보통'),
                    ],
                  )
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50)),
                  onPressed: () {},
                  child: Icon(Icons.refresh)),
            )
          ],
        ),
      ),
    );
  }
}