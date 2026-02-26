import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_manager/core/services/storage/preference_service.dart';
import 'package:expense_manager/features/transaction/models/transaction_with_category_model.dart';
import 'package:expense_manager/features/transaction/repositories/transaction_local_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final TransactionLocalRepo repo = TransactionLocalRepo();
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboard>(_loadDashboard);
    on<RefreshDashboard>(_loadDashboard);
  }

  FutureOr<void> _loadDashboard(
    DashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    final String name = PreferencesService().nickname ?? "-null";
    try {
      final transactions = await repo.getTransactions();

      final totalIncome = transactions
          .where((e) => e.type == "credit")
          .fold<double>(0, (sum, e) => sum + e.amount);

      final totalExpense = transactions
          .where((e) => e.type == "debit")
          .fold<double>(0, (sum, e) => sum + e.amount);

      final recent = transactions
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

      emit(
        DashboardLoaded(
          totalIncome: totalIncome,
          totalExpense: totalExpense,
          recentTransactions: recent.take(10).toList(),
          name: name,
        ),
      );
    } catch (e) {
      emit(DashboardError("Failed to load dashboard"));
    }
  }
}
