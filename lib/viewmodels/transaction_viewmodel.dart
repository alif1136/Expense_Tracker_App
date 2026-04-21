import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction_model.dart';

class TransactionViewModel extends ChangeNotifier {
  static const String _storageKey = 'transactions';
  final List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions =>
      List.unmodifiable(_transactions.reversed);

  double get totalIncome => _transactions
      .where((t) => t.type == TransactionType.income)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpense => _transactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalBalance => totalIncome - totalExpense;

  TransactionViewModel() {
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_storageKey);
    if (stored != null) {
      final List<dynamic> decoded = jsonDecode(stored);
      _transactions
        ..clear()
        ..addAll(decoded
            .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>)));
      notifyListeners();
    }
  }

  Future<void> _saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
    jsonEncode(_transactions.map((t) => t.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  Future<void> addTransaction({
    required String title,
    required double amount,
    required DateTime date,
    required TransactionType type,
  }) async {
    final tx = TransactionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      date: date,
      type: type,
    );
    _transactions.add(tx);
    await _saveTransactions();
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    _transactions.removeWhere((t) => t.id == id);
    await _saveTransactions();
    notifyListeners();
  }
}