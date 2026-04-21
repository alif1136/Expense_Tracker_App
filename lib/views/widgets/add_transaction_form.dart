import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/transaction_model.dart';
import '../../theme/app_theme.dart';
import '../../viewmodels/transaction_viewmodel.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  DateTime _date = DateTime.now();
  TransactionType _type = TransactionType.expense;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: AppColors.primaryFg,
            onSurface: AppColors.foreground,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final amount = double.parse(_amountCtrl.text);
    context.read<TransactionViewModel>().addTransaction(
      title: _titleCtrl.text.trim(),
      amount: amount,
      date: _date,
      type: _type,
    );
    _titleCtrl.clear();
    _amountCtrl.clear();
    setState(() {
      _date = DateTime.now();
      _type = TransactionType.expense;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: Text(
          'Transaction added — your ledger has been updated.',
          style: TextStyle(color: AppColors.primaryFg),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('New Entry',
                  style: AppTheme.serif(fontSize: 24, color: AppColors.foreground)),
              const SizedBox(height: 20),
              _label('DESCRIPTION'),
              TextFormField(
                controller: _titleCtrl,
                style: const TextStyle(fontSize: 17),
                decoration: const InputDecoration(
                  hintText: 'E.g. Morning coffee',
                  hintStyle: TextStyle(color: AppColors.mutedFg),
                ),
                validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Title is required' : null,
              ),
              const SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('AMOUNT'),
                        TextFormField(
                          controller: _amountCtrl,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          style: const TextStyle(
                              fontSize: 17, fontFeatures: [FontFeature.tabularFigures()]),
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            prefixStyle:
                            TextStyle(color: AppColors.mutedFg, fontSize: 17),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Required';
                            final n = double.tryParse(v);
                            if (n == null || n <= 0) return 'Must be > 0';
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('DATE'),
                        InkWell(
                          onTap: _pickDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: AppColors.border, width: 2),
                              ),
                            ),
                            child: Text(
                              DateFormat('MMM d, yyyy').format(_date),
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _label('TYPE'),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColors.border, width: 2)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<TransactionType>(
                    value: _type,
                    isExpanded: true,
                    icon: const Icon(Icons.expand_more,
                        color: AppColors.mutedFg),
                    style: const TextStyle(
                        fontSize: 17, color: AppColors.foreground),
                    items: [
                      DropdownMenuItem(
                        value: TransactionType.expense,
                        child: Text('Expense',
                            style: TextStyle(
                                color: AppColors.destructive,
                                fontWeight: FontWeight.w500)),
                      ),
                      DropdownMenuItem(
                        value: TransactionType.income,
                        child: Text('Income',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                    onChanged: (v) => setState(() => _type = v!),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add to Ledger'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(text, style: AppTheme.mono()),
  );
}
