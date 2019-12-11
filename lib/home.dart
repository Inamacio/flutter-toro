import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:navigation/sake.dart';
import 'package:navigation/sale.dart';
import 'package:navigation/purchase.dart';
import 'package:navigation/deposit.dart';
import 'package:navigation/urlRequest.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _Home();
}

class _Home extends State<Home> {
  final Color green = Color(0XFF03A9F4);
  String balance;
  String name;
  String email;


  Future<http.Response> getRequest () async {
    var url = UrlRequest.getUrl();


    try {
      var response = await http.get(url,
        headers: {"Content-Type": "application/json"},
      );
      Map<String, dynamic> jsonData = json.decode(response.body);
      this.name = jsonData['name'];
      this.email = jsonData['email'];
      this.balance = jsonData['balance'].toString();
    } catch(e) {
      this.name = 'Erro ao retornar os dados';
      this.email = 'Email dault';
      this.balance = '';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    getRequest();
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 16),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              color: green,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32)),
            ),
            child: Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 20),
                  child: Text(
                    this.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Saldo: ' + this.balance,
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 32),
                  child: Text(
                    'E-mail:' + this.email,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.attach_money,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SakePage()));
                                },
                              ),
                              Text(
                                'Saquê',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              DepositPage()));
                                },
                              ),
                              Text(
                                'Deposito',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              IconButton(
                                icon:
                                Icon(Icons.show_chart, color: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SalePage()));
                                },
                              ),
                              Text(
                                'Vender ações',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              IconButton(
                                icon:
                                Icon(Icons.swap_horiz, color: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PurchasePage()));
                                },
                              ),
                              Text(
                                'Comprar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}



