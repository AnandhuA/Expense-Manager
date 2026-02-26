import 'package:uuid/uuid.dart';
import 'package:expense_manager/core/services/database/app_database.dart';
import 'package:expense_manager/core/services/database/db_tables.dart';
import '../models/category_model.dart';

class CategoryLocalRepo {
  final uuid = Uuid();

  /// ---------------- ADD CATEGORY ----------------
  Future<void> addCategory({required String name}) async {
    final db = await AppDatabase.instance.database;

    final category = CategoryModel(id: uuid.v4(), name: name);

    await db.insert(DbTables.categories, category.toMap());
  }

  /// ---------------- GET ALL ACTIVE ----------------
  Future<List<CategoryModel>> getCategories() async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      DbTables.categories,
      where: "is_deleted = 0",
      orderBy: "name ASC",
    );

    return result.map((e) => CategoryModel.fromMap(e)).toList();
  }

  /// ---------------- GET SINGLE CATEGORY ----------------
  Future<CategoryModel?> getCategoryById({required String id}) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      DbTables.categories,
      where: "id = ? AND is_deleted = 0",
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return CategoryModel.fromMap(result.first);
  }

  /// ---------------- UPDATE CATEGORY ----------------
  Future<void> updateCategory({required CategoryModel category}) async {
    final db = await AppDatabase.instance.database;

    await db.update(
      DbTables.categories,
      {"name": category.name, "is_synced": 0},
      where: "id = ?",
      whereArgs: [category.id],
    );
  }

  /// ---------------- SOFT DELETE ----------------
  Future<void> deleteCategory({required String id}) async {
    final db = await AppDatabase.instance.database;

    await db.update(
      DbTables.categories,
      {"is_deleted": 1, "is_synced": 0},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// ---------------- HARD DELETE (optional) ----------------
  Future<void> deleteCategoryPermanently({required String id}) async {
    final db = await AppDatabase.instance.database;

    await db.delete(DbTables.categories, where: "id = ?", whereArgs: [id]);
  }
}
