import 'package:expense_manager/core/services/local_db/app_database.dart';
import 'package:expense_manager/core/services/local_db/db_tables.dart';
import 'package:expense_manager/features/transaction/models/transaction_model.dart';
import 'package:expense_manager/features/transaction/models/transaction_with_category_model.dart';
import 'package:uuid/uuid.dart';

class TransactionLocalRepo {
  final uuid = Uuid();

  //---------- Add transation ------------
  Future<void> addTransaction({
    required double amount,
    required String note,
    required String type,
    required String categoryId,
  }) async {
    final db = await AppDatabase.instance.database;

    final tx = TransactionModel(
      id: uuid.v4(),
      amount: amount,
      note: note,
      type: type,
      categoryId: categoryId,
      timestamp: DateTime.now().toIso8601String(),
    );

    await db.insert(DbTables.transactions, tx.toMap());
  }

  //------------- get all transactions --------
  Future<List<TransactionWithCategoryModel>> getTransactions() async {
    final db = await AppDatabase.instance.database;

    final result = await db.rawQuery('''
    SELECT 
      t.id,
      t.amount,
      t.note,
      t.type,
      t.timestamp,
      t.category_id,
      c.name as category_name
    FROM transactions t
    JOIN categories c
    ON t.category_id = c.id
    WHERE t.is_deleted = 0
    ORDER BY t.timestamp DESC
  ''');

    return result.map((e) => TransactionWithCategoryModel.fromMap(e)).toList();
  }

  //--------- update -----------
  Future<void> updateTransaction(TransactionModel tx) async {
    final db = await AppDatabase.instance.database;

    await db.update(
      DbTables.transactions,
      tx.toMap(),
      where: "id = ?",
      whereArgs: [tx.id],
    );
  }

  //---------delete --------
  Future<void> deleteTransaction(String id) async {
    final db = await AppDatabase.instance.database;

    await db.update(
      DbTables.transactions,
      {"is_deleted": 1, "is_synced": 0},
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
