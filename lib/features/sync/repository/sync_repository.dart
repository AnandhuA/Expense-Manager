import 'package:expense_manager/core/services/database/local_db.dart';
import 'package:expense_manager/core/services/network/api_service.dart';

class SyncRepository {
  final ApiService api = ApiService();
  final LocalDb db= LocalDb();

 

  Future<void> syncDeletedTransactions() async {
    final ids = await db.getDeletedTransactionIds();
    if (ids.isEmpty) return;

    await api.deleteTransactions(ids);
    await db.hardDeleteTransactions(ids);
  }

  Future<void> syncDeletedCategories() async {
    final ids = await db.getDeletedCategoryIds();
    if (ids.isEmpty) return;

    await api.deleteCategories(ids);
    await db.hardDeleteCategories(ids);
  }

  Future<void> syncCategories() async {
    final cats = await db.getUnsyncedCategories();
    if (cats.isEmpty) return;

    final syncedIds = await api.uploadCategories(cats);
    await db.markCategoriesSynced(syncedIds);
  }

  Future<void> syncTransactions() async {
    final txns = await db.getUnsyncedTransactions();
    if (txns.isEmpty) return;

    final syncedIds = await api.uploadTransactions(txns);
    await db.markTransactionsSynced(syncedIds);
  }
}