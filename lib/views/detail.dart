import 'package:flutter/material.dart';
import 'input.dart';
import '../db/tickets.dart';

class MyHomePage3 extends StatefulWidget {
  const MyHomePage3({super.key, required this.db, required this.ticket});

  final MyDB db;
  final Ticket ticket;

  @override
  State<MyHomePage3> createState() => _MyHomePage3State();
}

class _MyHomePage3State extends State<MyHomePage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ticket.title),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Title'),
            subtitle: Text(widget.ticket.title),
          ),
          ListTile(
            title: const Text('Start date'),
            subtitle: Text('${widget.ticket.startDate}'),
          ),
          const ListTile(
            title: Text('name 3'),
            subtitle: Text('age 3'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage2(db: widget.db),
            ),
          ),
        },
        // child: const Icon(Icons.delete),
        child: const Icon(Icons.edit),
      ),
    );
  }
}
