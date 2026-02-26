import 'package:sqflite/sqflite.dart';
import 'app_database.dart';
import 'db_tables.dart';

class LocalDb {
  Future<Database> get _db async => await AppDatabase.instance.database;

  // ---------------- Deleted ----------------

  Future<List<String>> getDeletedTransactionIds() async {
    final db = await _db;
    final res = await db.query(
      DbTables.transactions,
      columns: ['id'],
      where: 'is_deleted = 1',
    );
    return res.map((e) => e['id'] as String).toList();
  }

  Future<void> hardDeleteTransactions(List<String> ids) async {
    if (ids.isEmpty) return;
    final db = await _db;
    await db.delete(
      DbTables.transactions,
      where: 'id IN (${List.filled(ids.length, '?').join(',')})',
      whereArgs: ids,
    );
  }

  Future<List<String>> getDeletedCategoryIds() async {
    final db = await _db;
    final res = await db.query(
      DbTables.categories,
      columns: ['id'],
      where: 'is_deleted = 1',
    );
    return res.map((e) => e['id'] as String).toList();
  }

  Future<void> hardDeleteCategories(List<String> ids) async {
    if (ids.isEmpty) return;
    final db = await _db;
    await db.delete(
      DbTables.categories,
      where: 'id IN (${List.filled(ids.length, '?').join(',')})',
      whereArgs: ids,
    );
  }

  // ---------------- Unsynced ----------------

  Future<List<Map<String, dynamic>>> getUnsyncedCategories() async {
    final db = await _db;
    return await db.query(
      DbTables.categories,
      where: 'is_synced = 0 AND is_deleted = 0',
    );
  }

  Future<void> markCategoriesSynced(List<String> ids) async {
    if (ids.isEmpty) return;
    final db = await _db;
    await db.update(
      DbTables.categories,
      {'is_synced': 1},
      where: 'id IN (${List.filled(ids.length, '?').join(',')})',
      whereArgs: ids,
    );
  }

  Future<List<Map<String, dynamic>>> getUnsyncedTransactions() async {
    final db = await _db;
    return await db.query(
      DbTables.transactions,
      where: 'is_synced = 0 AND is_deleted = 0',
    );
  }

  Future<void> markTransactionsSynced(List<String> ids) async {
    if (ids.isEmpty) return;
    final db = await _db;
    await db.update(
      DbTables.transactions,
      {'is_synced': 1},
      where: 'id IN (${List.filled(ids.length, '?').join(',')})',
      whereArgs: ids,
    );
  }
}