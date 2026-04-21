import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'viewmodels/transaction_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  runApp(const LedgerApp());
}

class LedgerApp extends StatelessWidget {
  const LedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransactionViewModel(),
      child: MaterialApp(
        title: 'Ledger',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const HomeView(),
      ),
    );
  }
}
