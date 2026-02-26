import 'dart:developer';

import 'package:expense_manager/core/services/database/local_db.dart';
import 'package:expense_manager/core/services/network/api_service.dart';
import 'package:expense_manager/features/categories/models/category_model.dart';
import 'package:expense_manager/features/transaction/models/transaction_model.dart';

class SyncRepository {
  final ApiService api = ApiService();
  final LocalDb db = LocalDb();

  // MASTER SYNC METHOD
  Future<void> syncAll() async {
    try {
      await syncDeletedTransactions();
      await syncDeletedCategories();

      await syncCategories();
      await syncTransactions();
    } catch (e) {
      log("Sync error: $e");
    }
  }

  // DELETE TRANSACTIONS (SYNC FIRST)
  Future<void> syncDeletedTransactions() async {
    try {
      final ids = await db.getDeletedTransactionIds();
      if (ids.isEmpty) return;

      for (final id in ids) {
        await api.deleteTransaction(id);
      }
      await db.hardDeleteTransactions(ids);
    } catch (e) {
      log("syncDeletedTransactions error: $e");
    }
  }

  // DELETE CATEGORIES
  Future<void> syncDeletedCategories() async {
    try {
      final ids = await db.getDeletedCategoryIds();
      if (ids.isEmpty) return;

      for (final id in ids) {
        await api.deleteCategory(id);
      }
      await db.hardDeleteCategories(ids);
    } catch (e) {
      log("syncDeletedCategories error: $e");
    }
  }

  //  UPLOAD NEW/UPDATED CATEGORIES
  Future<void> syncCategories() async {
    try {
      final List<Map<String, dynamic>> cats = await db.getUnsyncedCategories();
      final List<CategoryModel> categoryModelList = cats
          .map((e) => CategoryModel.fromMap(e))
          .toList();
      if (categoryModelList.isEmpty) return;

      final syncedIds = await api.uploadCategories(categoryModelList);

      if (syncedIds.isNotEmpty) {
        await db.markCategoriesSynced(syncedIds);
      }
    } catch (e) {
      log("syncCategories error: $e");
    }
  }

  //UPLOAD NEW/UPDATED TRANSACTIONS
  Future<void> syncTransactions() async {
    try {
      final txns = await db.getUnsyncedTransactions();
      final List<TransactionModel> transactionsList = txns
          .map((e) => TransactionModel.fromMap(e))
          .toList();
      if (txns.isEmpty) return;

      final syncedIds = await api.uploadTransactions(transactionsList);

      if (syncedIds.isNotEmpty) {
        await db.markTransactionsSynced(syncedIds);
      }
    } catch (e) {
      log("syncTransactions error: $e");
    }
  }
}
