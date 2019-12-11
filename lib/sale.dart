import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:navigation/urlRequest.dart';

class SalePage extends StatelessWidget {
  var shares = ['GOL40', 'XAM90', 'TORO6'];
  var sharesValues = ['40', '30', '10'];
  var stocks;


  submit(name, value) async {
    await postRequest(name, value);
  }

  Future<http.Response> postRequest (name, value) async {
    var url = UrlRequest.getUrl();

    Map data = {
      'type': 'sale',
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

  Future<http.Response> getRequest () async {
    var url = UrlRequest.getUrl();

    print('estou auqi');
    try {
      var response = await http.get(url,
        headers: {"Content-Type": "application/json"},
      );
      print(response.body);
      Map<String, dynamic> jsonData = json.decode(response.body);
      this.stocks = jsonData['stocks'];
    } catch(e) {
      this.stocks = [];
    }

    return null;
  }


  @override
  Widget build(BuildContext context) {
    getRequest();
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
                  Text('Você confirmar a venda: ' + name + '?'),
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
