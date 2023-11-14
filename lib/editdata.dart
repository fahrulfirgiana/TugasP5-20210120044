import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  final List list;
  final int index;

  const Edit({Key? key, required this.list, required this.index})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  late TextEditingController name;
  late TextEditingController address;
  late TextEditingController salary;

  void editData() async {
    var url = Uri.parse(
        'http://192.168.106.73/tugasp5/restapi/update.php'); //update api calling
    http.post(url, body: {
      'id': widget.list[widget.index]['id'],
      'name': name.text,
      'address': address.text,
      'salary': salary.text,
    });
  }

  @override
  void initState() {
    name = TextEditingController(text: widget.list[widget.index]['name']);
    address = TextEditingController(text: widget.list[widget.index]['address'] ?? '');
    salary = TextEditingController(text: widget.list[widget.index]['salary'] ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Data"),
        shape: const BeveledRectangleBorder(),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
            child: TextFormField(
              controller: name,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: TextFormField(
              controller: address,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Address',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: salary,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Salary',
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: MaterialButton(
              padding: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 20),
              color: Colors.indigo,
              onPressed: () {
                if (name.text.isNotEmpty && address.text.isNotEmpty && salary.text.isNotEmpty) {
                  editData();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Home(),
                    ),
                  );
                } else {
                  // Handle empty input case, e.g., show a message to the user.
                }
              },
              child: const Text(
                "Edit Data",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
