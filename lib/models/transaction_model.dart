enum TransactionType { income, expense }

class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'amount': amount,
    'date': date.toIso8601String(),
    'type': type.name,
  };

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      type: TransactionType.values.firstWhere(
            (e) => e.name == json['type'],
        orElse: () => TransactionType.expense,
      ),
    );
  }
}