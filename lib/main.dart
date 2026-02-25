import 'package:expense_manager/core/services/storage/preference_service.dart';
import 'package:expense_manager/core/theme/app_theme.dart';
import 'package:expense_manager/features/auth/bloc/auth_bloc.dart';
import 'package:expense_manager/features/categories/bloc/category_bloc.dart';
import 'package:expense_manager/features/splash/splash_screen.dart';
import 'package:expense_manager/features/transaction/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(
          create: (_) =>
              CategoryBloc()..add(LoadCategories()), // load immediately
        ),
        BlocProvider(create: (_) => TransactionBloc()..add(LoadTransactions())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: SplashScreen(),
      ),
    );
  }
}
