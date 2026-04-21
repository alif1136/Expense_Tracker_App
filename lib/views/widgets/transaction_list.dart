import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/transaction_model.dart';
import '../../theme/app_theme.dart';
import '../../viewmodels/transaction_viewmodel.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransactionViewModel>();
    final items = vm.transactions;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: items.isEmpty
          ? const _EmptyState()
          : Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _TransactionRow(tx: items[i]),
            if (i != items.length - 1)
              const Divider(
                  height: 1, thickness: 1, color: AppColors.border),
          ],
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco_outlined,
                size: 30, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          Text('A fresh page',
              style: AppTheme.serif(fontSize: 22, color: AppColors.primary)),
          const SizedBox(height: 8),
          const Text(
            'Your ledger is empty. Add your first transaction above.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.mutedFg, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  final TransactionModel tx;
  const _TransactionRow({required this.tx});

  @override
  Widget build(BuildContext context) {
    final isIncome = tx.type == TransactionType.income;
    final amountColor = isIncome ? AppColors.primary : AppColors.foreground;
    final tintBg = isIncome
        ? AppColors.primary.withOpacity(0.10)
        : AppColors.destructive.withOpacity(0.10);
    final tintFg = isIncome ? AppColors.primary : AppColors.destructive;
    final formatted =
    NumberFormat.currency(locale: 'en_US', symbol: '\$').format(tx.amount);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: tintBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isIncome ? Icons.arrow_upward : Icons.arrow_downward,
              color: tintFg,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.foreground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  DateFormat('MMM d, yyyy').format(tx.date),
                  style: AppTheme.mono(fontSize: 11, letterSpacing: 0.4),
                ),
              ],
            ),
          ),
          Text(
            '${isIncome ? '+' : '-'}$formatted',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: amountColor,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline,
                size: 20, color: AppColors.mutedFg),
            onPressed: () =>
                context.read<TransactionViewModel>().deleteTransaction(tx.id),
            tooltip: 'Delete',
          ),
        ],
      ),
    );
  }
}
