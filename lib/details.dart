import 'package:flutter/material.dart';
import 'editdata.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  final List list;
  final int index;
  // ignore: use_key_in_widget_constructors
  const Details({Key? key, required this.list, required this.index});

  @override
  // ignore: library_private_types_in_public_api
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void delete() {
    var url = Uri.parse('http://192.168.106.73/tugasp5/restapi/delete.php');
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Are You Sure?"),
      actions: [
        MaterialButton(
          child: const Text("YES DELETE"),
          onPressed: () {
            delete();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => const Home()),
            );
          },
        ),
        MaterialButton(
          child: const Text("NO.."),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        shape: const BeveledRectangleBorder(),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                "Name: ${widget.list[widget.index]['name']}",
                style: const TextStyle(fontSize: 20.0),
              ),
              subtitle: Text("Address: ${widget.list[widget.index]['address']}\n"
                  "Salary: ${widget.list[widget.index]['salary']}"),
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Edit(list: widget.list, index: widget.index)),
                      );
                    },
                    child: const Text("Edit Data"),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      confirm();
                    },
                    child: const Text("Delete"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
