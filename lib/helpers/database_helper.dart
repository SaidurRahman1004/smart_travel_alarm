import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../features/alarm/data/models/alarm_model.dart';

class DatabaseHelper {
  //singleton instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static DatabaseHelper get instance => _instance;
  static Database? _db;

  //database getter for finding database
  Future<Database> get database async {
    //check if database is already created
    if (_db != null) return _db!;
    //if not create new database then return it initialize database
    _db = await _initDatabase();
    return _db!;
  }

  //Creating Database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    //db file name
    final path = join(dbPath, 'alarms.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //create new table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE alarms (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dateTime TEXT NOT NULL,
        isActive INTEGER NOT NULL
      )
    ''');
  }

  //Curd Operations
  //create new alarm
  Future<AlarmModel> createAlarm(AlarmModel alarm) async {
    final db = await instance.database;
    final id = await db.insert('alarms', alarm.toMap());
    return alarm.copyWith(id: id);
  }

  //fetch all alarm
  Future<List<AlarmModel>> readAllAlarms() async {
    final db = await instance.database;
    final results = await db.query('alarms', orderBy: 'dateTime ASC');
    return results.map((e) => AlarmModel.fromMap(e)).toList();
  }

  //update alarm
  Future<int> update(AlarmModel alarm) async {
    final db = await instance.database;
    return db.update(
      'alarms',
      alarm.toMap(),
      where: 'id = ?',
      whereArgs: [alarm.id],
    );
  }

  //delete alarm
  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete('alarms', where: 'id = ?', whereArgs: [id]);
  }
}
