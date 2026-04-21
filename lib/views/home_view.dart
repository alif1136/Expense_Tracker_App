import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../viewmodels/transaction_viewmodel.dart';
import 'widgets/add_transaction_form.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/transaction_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransactionViewModel>();

    if (!vm.isLoaded) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(),
              const SizedBox(height: 32),
              const DashboardCard(),
              const SizedBox(height: 24),
              const AddTransactionForm(),
              const SizedBox(height: 32),
              Text(
                'Recent Transactions',
                style: AppTheme.serif(
                  fontSize: 26,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              const TransactionList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.eco_outlined, color: AppColors.primary, size: 30),
            const SizedBox(width: 10),
            Text(
              'Ledger',
              style: AppTheme.serif(
                fontSize: 42,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'A calm, intentional space to track where your money goes.',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.mutedFg,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
