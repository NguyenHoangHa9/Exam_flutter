import 'package:exam_flutter/place.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'places.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE places(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, imageUrl TEXT)',
        );
      },
    );
  }

  Future<void> insertPlace(Place place) async {
    final db = await database;
    await db.insert(
      'places',
      place.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Place>> getAllPlaces() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('places');
    return List.generate(maps.length, (i) {
      return Place.fromMap(maps[i]);
    });
  }
}
