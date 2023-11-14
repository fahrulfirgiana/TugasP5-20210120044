// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'details.dart';
import 'newdata.dart';

void main() => runApp(MaterialApp(
      title: "API Test",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _dataList = [];

  Future<void> getData() async {
    var url = Uri.parse('http://192.168.106.73/tugasp5/restapi/list.php');
    final response = await http.get(url);
    setState(() {
      _dataList = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PHP MySQL CRUD"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const NewData(),
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.indigo,
        elevation: 2,
      ),
      extendBody: true,
      body: Items(list: _dataList),
    );
  }
}

class Items extends StatelessWidget {
  final List list;
  const Items({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (ctx, i) {
        int counter = i + 1; // Menggunakan i + 1 karena indeks dimulai dari 0
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            elevation: 2.0,
            child: ListTile(
              contentPadding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 20.0),
                  SizedBox(
                    width: 40.0,
                    child: Text(
                      "$counter",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: ${list[i]['name']}",
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "Address: ${list[i]['address']}",
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "Salary: ${list[i]['salary']}",
                          style: const TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Details(list: list, index: i),
                          ),
                        );
                      },
                      child: const Text("View Details"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
