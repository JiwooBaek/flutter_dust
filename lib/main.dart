import 'package:flutter/material.dart';
import 'package:flutter_dust/models/AirResult.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  AirResult? _result;

  Future<AirResult> fetchData() async{
    var response = await http.get(Uri.parse('https://api.airvisual.com/v2/nearest_city?key=494ddf20-d03a-4f9d-8d28-f767bd3497c9'));

    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }
  
  @override
  void initState() {
    super.initState();
    
    fetchData().then((airResult) => {
      setState(() {
        _result = airResult;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _result == null ? CircularProgressIndicator() :
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('현재 위치 미세먼지', style: TextStyle(fontSize: 30),),
                SizedBox(
                  height: 16,
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('얼굴 사진'),
                            Text('${_result?.data?.current?.pollution?.aqius}', style: TextStyle(fontSize: 40),),
                            Text(getString(_result!), style: TextStyle(fontSize: 20),),
                          ],
                        ),
                        color: getColor(_result!),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              children: [
                                Image.network('https://airvisual.com/images/${_result?.data?.current?.weather?.ic?.replaceAll('n','')}d.png', width: 32, height: 32),
                                SizedBox(
                                  width: 16,
                                ),
                                Text('${_result?.data?.current?.weather?.tp}', style: TextStyle(fontSize: 16),)
                              ],
                            ),
                            Text('습도 ${_result?.data?.current?.weather?.hu}'),
                            Text('풍속 ${_result?.data?.current?.weather?.ws}m/s'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
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
        ),
      ),
    );
  }

 Color getColor(AirResult result) {
    if(result.data!.current!.pollution!.aqius! <= 50) {
      return Colors.greenAccent;
    } else if (result.data!.current!.pollution!.aqius! <= 100) {
      return Colors.yellow;
    } else if (result.data!.current!.pollution!.aqius! <= 150) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
 }

  String getString(AirResult result) {

    if(result.data!.current!.pollution!.aqius! <= 50) {
      return '좋음';
    } else if (result.data!.current!.pollution!.aqius! <= 100) {
      return '보통';
    } else if (result.data!.current!.pollution!.aqius! <= 150) {
      return '나쁨';
    } else {
      return '매우 나쁨';
    }

  }
}
