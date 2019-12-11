import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:navigation/urlRequest.dart';

class DepositPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _DepositPage();
}

class _DepositPage extends State<DepositPage> {
  String _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Depositar"),
      ),
      body: Container(
          padding: const EdgeInsets.all(40.0),
//        child: Center(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: new InputDecoration(labelText: "Quanto deseja depositar?"),
                keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    this._value = value;
                  }
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: RaisedButton(
                      onPressed: _submit,
                      child: Text('Depositar'),
                    ),
                  )
                ],
              )
            ],
          )
//        ),
      ),
    );
  }

  _submit() async {
    await postRequest();
  }

  Future<http.Response> postRequest () async {
    var url = UrlRequest.getUrl();

    Map data = {
      'balance': this._value,
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
}



