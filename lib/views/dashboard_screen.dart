import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import '../viewmodels/transaction_viewmodel.dart';
import 'add_transaction_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransactionViewModel>();
    final currency = NumberFormat.currency(symbol: '\$');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Total Balance',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(
                      currency.format(vm.totalBalance),
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _SummaryTile(
                          label: 'Income',
                          amount: currency.format(vm.totalIncome),
                          color: Colors.green,
                          icon: Icons.arrow_downward,
                        ),
                        _SummaryTile(
                          label: 'Expense',
                          amount: currency.format(vm.totalExpense),
                          color: Colors.red,
                          icon: Icons.arrow_upward,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Transactions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Expanded(
            child: vm.transactions.isEmpty
                ? const Center(
              child: Text('No transactions yet. Tap + to add one.'),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vm.transactions.length,
              itemBuilder: (context, index) {
                final tx = vm.transactions[index];
                final isIncome = tx.type == TransactionType.income;
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isIncome
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      child: Icon(
                        isIncome
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        color: isIncome ? Colors.green : Colors.red,
                      ),
                    ),
                    title: Text(tx.title),
                    subtitle: Text(
                        DateFormat.yMMMd().format(tx.date)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${isIncome ? '+' : '-'}${currency.format(tx.amount)}',
                          style: TextStyle(
                            color:
                            isIncome ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () =>
                              vm.deleteTransaction(tx.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => const AddTransactionScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  final String label;
  final String amount;
  final Color color;
  final IconData icon;

  const _SummaryTile({
    required this.label,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(label),
        Text(amount,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}