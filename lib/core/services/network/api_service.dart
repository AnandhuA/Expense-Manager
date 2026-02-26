import 'package:dio/dio.dart';
import 'package:expense_manager/core/services/network/dio_client.dart';
import 'package:expense_manager/features/categories/models/category_model.dart';
import 'package:expense_manager/features/transaction/models/transaction_model.dart';

class ApiService {
  final Dio _dio = DioClient().client;

  // ---------------- CATEGORIES ----------------

  /// Upload Categories (Batch)
  Future<List<String>> uploadCategories(
    List<CategoryModel> categories,
  ) async {
    final response = await _dio.post(
      "/categories/add/",
      data: {
        "categories": categories.map((e) => e.toMap()).toList(),
      },
    );

    return List<String>.from(response.data["synced_ids"]);
  }

  /// Delete Categories (Batch)
  Future<void> deleteCategories(List<String> ids) async {
    await _dio.delete(
      "/categories/delete/",
      data: {"ids": ids},
    );
  }

  // ---------------- TRANSACTIONS ----------------

  /// Upload Transactions (Batch)
  Future<List<String>> uploadTransactions(
    List<TransactionModel> transactions,
  ) async {
    final response = await _dio.post(
      "/transactions/add/",
      data: {
        "transactions": transactions.map((e) => e.toMap()).toList(),
      },
    );

    return List<String>.from(response.data["synced_ids"]);
  }

  /// Delete Transactions (Batch)
  Future<void> deleteTransactions(List<String> ids) async {
    await _dio.delete(
      "/transactions/delete/",
      data: {"ids": ids},
    );
  }
}