import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exibição de Texto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = TextEditingController();
  String resultado = '';

  Future<void> enviarTexto() async {
    final String apiUrl = "http://ec2-54-221-96-251.compute-1.amazonaws.com/v1/string";
    final String texto = textController.text;


    try {

      final response = await http.get(Uri.parse(apiUrl + "?string=$texto"));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          resultado = data['code'];
          print(resultado);
        });
      } else {
        setState(() {
          resultado = 'Erro: ${response.statusCode}';
          print(resultado);
        });
      }
    } catch (e) {
      
      setState(() {
        resultado = 'erro2: $e';
        print(resultado);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EGE desafio'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'Digite um texto'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: enviarTexto,
              child: Text('Enviar'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Resultado: $resultado',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}