import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testapp1/screens/home/domain/Person.dart';

class LocalStorage {
  LocalStorage._();
  static final LocalStorage db = LocalStorage._();
  static late Database _database;

  Future<Database> get database async {
    // if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "SimpleDB2.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE person ("
          "id INTEGER PRIMARY KEY,"
          "first TEXT,"
          "last TEXT,"
          "email TEXT,"
          "contact TEXT"
          ")");
    });
  }

  Future<List<Person>> getAllPersons() async {
    final db = await database;
    List<Map> results =
        await db.query("Person", columns: Person.columns, orderBy: "id ASC");
    List<Person> persons = [];
    results.forEach((result) {
      Person person = Person.fromMap(result);
      persons.add(person);
    });
    return persons;
  }

  insert(Person person) async {
    final db = await database;
    var maxIdResult =
        await db.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Person");
    var id = maxIdResult.first["last_inserted_id"];
    var result = await db.rawInsert(
        "INSERT Into Person (id, first, last, email, contact)"
        " VALUES (?, ?, ?, ?, ?)",
        [id, person.first, person.last, person.email, person.contact]);
    return result;
  }

  update(Person person) async {
    final db = await database;
    var result = await db.update("Person", person.toMap(),
        where: "id = ?", whereArgs: [person.id]);
    return result;
  }

  delete(int id) async {
    final db = await database;
    db.delete("Person", where: "id = ?", whereArgs: [id]);
  }
}
