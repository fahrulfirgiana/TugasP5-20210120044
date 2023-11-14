import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class NewData extends StatefulWidget {
  const NewData({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewDataState createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  void addData() async {
    var url = Uri.parse('http://192.168.106.73/tugasp5/restapi/create.php'); // API Insert
    final response = await http.post(url, body: {
      "name": nameController.text,
      "address": addressController.text,
      "salary": salaryController.text,
    });

    if (response.statusCode == 200) {
      // If successful, navigate back to the home page
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const Home(),
        ),
      );
    } else {
      // If failed, show an error dialog
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to add data.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Enter Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            TextFormField(
              controller: addressController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Enter Address',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            TextFormField(
              controller: salaryController,
              keyboardType: TextInputType.number, // Set keyboard type to number
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Enter Salary',
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                addData();
              },
              child: const Text("Add Data"),
            ),
          ],
        ),
      ),
    );
  }
}
