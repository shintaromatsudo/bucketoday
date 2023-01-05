import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'detail.dart';
import 'input.dart';
import '../db/tickets.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.db, required this.date_str});

  final MyDB db;
  final String date_str;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.date_str),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: widget.db.watchEnries(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Ticket>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount:
                        snapshot.data != null ? snapshot.data?.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Container(
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.yellow.withOpacity(.5),
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: NetworkImage(
                                "https://source.unsplash.com/random",
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          snapshot.data![index].title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${snapshot.data![index].startDate}',
                        ),
                        trailing: const Icon(Icons.navigate_next),
                        onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => MyHomePage3(
                                  db: widget.db, ticket: snapshot.data![index]),
                            ),
                          ),
                        },
                      );
                    });
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => MyHomePage2(db: widget.db),
            ),
          ),
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
