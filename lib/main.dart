import 'package:flutter/material.dart';
import 'views/list.dart';
// import 'list_page.dart';
// import 'detail.dart';
import 'db/tickets.dart';

void main() {
  final database = MyDB();
  runApp(MyApp(db: database));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.db}) : super(key: key);

  final MyDB db;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bucketoday',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: ListPage(db: db, date_str: 'Bucketoday'));
  }
}
