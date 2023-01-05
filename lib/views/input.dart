import 'package:flutter/material.dart';
import '../db/tickets.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({super.key, required this.db});

  final MyDB db;

  @override
  State<MyHomePage2> createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  String _text = '';

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bucketoday'),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Start date',
                ),
                onChanged: _handleText,
              ),
              Text(
                "$_text",
                style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                child: const Text('Add'),
                onPressed: () async {
                  final title = titleController.text;
                  final startDate = DateTime.now();
                  await widget.db.addTicket(title, startDate);
                },
              ),
            ],
          ),
        ));
  }
}
