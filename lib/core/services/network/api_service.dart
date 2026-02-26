import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:expense_manager/core/constants/api_endpoints.dart';
import 'package:expense_manager/core/services/network/dio_client.dart';
import 'package:expense_manager/features/categories/models/category_model.dart';
import 'package:expense_manager/features/transaction/models/transaction_model.dart';

class ApiService {
  final Dio _dio = DioClient().client;

  // ---------------- CATEGORIES ----------------

  /// Upload Categories (Batch)
  Future<List<String>> uploadCategories(List<CategoryModel> categories) async {
    try {
      List<String> syncedIds = [];

      for (final category in categories) {
        final formData = FormData.fromMap({
          "name": category.name,
          "category_id": category.id,
        });

        final response = await _dio.post(
          ApiEndpoints.addCategories,
          data: formData,
        );

        if (response.data["status"] == "success") {
          syncedIds.add(category.id);
        }
      }

      return syncedIds;
    } catch (e) {
      log("----$e");
      rethrow;
    }
  }

  /// Delete Categories (Batch)
 Future<void> deleteCategory(String id) async {
  try {
    final formData = FormData.fromMap({
      "category_id": id,
    });

    await _dio.delete(
      ApiEndpoints.deleteCategories,
      data: formData,
    );
  } on DioException catch (e) {
    if (e.response?.statusCode == 404) {
      // Already deleted in backend — treat as success
      return;
    }
    rethrow;
  }
}

  // ---------------- TRANSACTIONS ----------------

  /// Upload Transactions (Batch)
  Future<List<String>> uploadTransactions(
    List<TransactionModel> transactions,
  ) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.addTransactions,
        data: {"transactions": transactions.map((e) => e.toMap()).toList()},
      );
      final data = response.data;

      if (data == null || data["synced_ids"] == null) {
        return [];
      }
      return List<String>.from(response.data["synced_ids"]);
    } catch (e) {
      log("===$e");
      rethrow;
    }
  }

Future<void> deleteTransaction(String id) async {
  try {
    final formData = FormData.fromMap({
      "transaction_id": id,
    });

    await _dio.delete(
      ApiEndpoints.deleteTransactions,
      data: formData,
    );
  } on DioException catch (e) {
    if (e.response?.statusCode == 404) {
      // Already deleted or not exists — treat as success
      return;
    }
    rethrow;
  }
}
}
