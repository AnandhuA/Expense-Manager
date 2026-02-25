class CategoryModel {
  final String id;
  final String name;
  final int isSynced;
  final int isDeleted;

  CategoryModel({
    required this.id,
    required this.name,
    this.isSynced = 0,
    this.isDeleted = 0,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      isSynced: map['is_synced'] ?? 0,
      isDeleted: map['is_deleted'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "is_synced": isSynced,
      "is_deleted": isDeleted,
    };
  }
}