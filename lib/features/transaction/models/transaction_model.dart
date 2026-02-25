class TransactionModel {
  final String id;
  final double amount;
  final String note;
  final String type;
  final String categoryId;
  final String timestamp;
  final int isSynced;
  final int isDeleted;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.note,
    required this.type,
    required this.categoryId,
    required this.timestamp,
    this.isSynced = 0,
    this.isDeleted = 0,
  });

  /// MAP → MODEL
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      amount: (map['amount'] as num).toDouble(),
      note: map['note'] ?? "",
      type: map['type'],
      categoryId: map['category_id'],
      timestamp: map['timestamp'] ?? "",
      isSynced: map['is_synced'] ?? 0,
      isDeleted: map['is_deleted'] ?? 0,
    );
  }

  /// MODEL → MAP (for DB insert/update)
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "amount": amount,
      "note": note,
      "type": type,
      "category_id": categoryId,
      "timestamp": timestamp,
      "is_synced": isSynced,
      "is_deleted": isDeleted,
    };
  }
}