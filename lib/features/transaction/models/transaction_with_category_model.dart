class TransactionWithCategoryModel {
  final String id;
  final double amount;
  final String note;
  final String type;
  final String timestamp;
  final String categoryId;
  final String categoryName;

  TransactionWithCategoryModel({
    required this.id,
    required this.amount,
    required this.note,
    required this.type,
    required this.timestamp,
    required this.categoryId,
    required this.categoryName,
  });

  factory TransactionWithCategoryModel.fromMap(Map<String, dynamic> map) {
    return TransactionWithCategoryModel(
      id: map['id'],
      amount: (map['amount'] as num).toDouble(),
      note: map['note'] ?? "",
      type: map['type'],
      timestamp: map['timestamp'] ?? "",
      categoryId: map['category_id'],
      categoryName: map['category_name'] ?? "",
    );
  }
}
