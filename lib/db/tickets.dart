import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p_dev;

part 'tickets.g.dart';

const _uuid = Uuid();

class Tickets extends Table {
  TextColumn get id => text().clientDefault(() => _uuid.v4())();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get repeat => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  BoolColumn get deleted => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Tickets])
class MyDB extends _$MyDB {
  MyDB() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<Ticket>> watchEnries() {
    return (select(tickets)).watch();
  }

  // read
  Future<List<Ticket>> get listTickets => select(tickets).get();

  // create
  Future<int> addTicket(String title, DateTime startDate) {
    return into(tickets).insert(
        TicketsCompanion(title: Value(title), startDate: Value(startDate)));
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p_dev.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
