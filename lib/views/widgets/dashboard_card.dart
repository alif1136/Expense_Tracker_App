import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_theme.dart';
import '../../../viewmodels/transaction_viewmodel.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key});

  String _money(double v) =>
      NumberFormat.currency(locale: 'en_US', symbol: '\$').format(v);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransactionViewModel>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.15),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16,
            right: 16,
            child: Opacity(
              opacity: 0.10,
              child: Icon(
                Icons.account_balance_wallet_outlined,
                size: 110,
                color: AppColors.primaryFg,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL BALANCE',
                  style: AppTheme.mono(
                    fontSize: 11,
                    color: AppColors.primaryFg.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _money(vm.totalBalance),
                  style: AppTheme.serif(
                    fontSize: 44,
                    color: AppColors.primaryFg,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  height: 1,
                  color: AppColors.primaryFg.withOpacity(0.12),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _Stat(
                        icon: Icons.trending_up,
                        label: 'INCOME',
                        value: _money(vm.totalIncome),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: AppColors.primaryFg.withOpacity(0.12),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _Stat(
                        icon: Icons.trending_down,
                        label: 'EXPENSE',
                        value: _money(vm.totalExpense),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _Stat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 12, color: AppColors.primaryFg.withOpacity(0.7)),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTheme.mono(
                fontSize: 10,
                color: AppColors.primaryFg.withOpacity(0.7),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: AppTheme.mono(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryFg,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}
