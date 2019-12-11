import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:navigation/urlRequest.dart';

class PurchasePage extends StatelessWidget {
  final shares = ['GOL40', 'XAM90', 'TORO6'];
  final sharesValues = ['40', '30', '10'];

  submit(name, value) async {
    await postRequest(name, value);
  }

  Future<http.Response> postRequest (name, value) async {
    var url = UrlRequest.getUrl();

    Map data = {
      'type': 'purchase',
      'name': name,
      'value': value,
    };
    //encode Map to JSON
    var body = json.encode(data);

    print(body);

    var response = await http.put(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _neverSatisfied(name, value) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Aviso'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Você confirmar a compra: ' + name + '?'),
                  Text('Valor: ' + value),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Não'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Sim'),
                onPressed: () {
                  submit(name, value);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Comprar ações"),
      ),
      body: Container(
        child: Center(
            child: ListView.builder(
              itemCount: shares.length,
              itemBuilder: (context, index) {
                return Card(
                  // <-- Card widget
                  child: ListTile(
                    onTap: () =>
                        _neverSatisfied(shares[index], sharesValues[index]),
                    title: Text(shares[index]),
                    subtitle: Text("Valor: " + sharesValues[index]),
                  ),
                );
              },
            )),
      ),
    );
  }
}
