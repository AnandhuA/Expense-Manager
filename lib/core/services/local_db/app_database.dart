import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'db_tables.dart';

class AppDatabase {
  AppDatabase._internal();
  static final AppDatabase instance = AppDatabase._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), "expense_manager.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {

    /// CATEGORY TABLE
    await db.execute('''
      CREATE TABLE ${DbTables.categories}(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        is_synced INTEGER DEFAULT 0,
        is_deleted INTEGER DEFAULT 0
      )
    ''');

    /// TRANSACTION TABLE
    await db.execute('''
      CREATE TABLE ${DbTables.transactions}(
        id TEXT PRIMARY KEY,
        amount REAL NOT NULL,
        note TEXT,
        type TEXT NOT NULL,
        category_id TEXT NOT NULL,
        timestamp TEXT,
        is_synced INTEGER DEFAULT 0,
        is_deleted INTEGER DEFAULT 0,
        FOREIGN KEY(category_id) REFERENCES ${DbTables.categories}(id)
      )
    ''');
  }
}