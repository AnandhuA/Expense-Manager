import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_manager/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:expense_manager/features/transaction/models/transaction_with_category_model.dart';
import 'package:expense_manager/features/transaction/repositories/transaction_local_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionLocalRepo repo;
  final DashboardBloc dashboardBloc;
  TransactionBloc({required this.repo, required this.dashboardBloc})
    : super(TransactionInitial()) {
    on<LoadTransactions>(_loadTransactions);
    on<AddTransaction>(_addTransaction);
    on<DeleteTransaction>(_deleteTransaction);
  }

  FutureOr<void> _loadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final list = await repo.getTransactions();
      emit(TransactionLoaded(transactions: list));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  FutureOr<void> _addTransaction(
    AddTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      await repo.addTransaction(
        amount: event.amount,
        note: event.note,
        type: event.type,
        categoryId: event.categoryId,
      );

      final list = await repo.getTransactions();
      emit(TransactionLoaded(transactions: list));
      dashboardBloc.add(const RefreshDashboard());
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  FutureOr<void> _deleteTransaction(
    DeleteTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      await repo.deleteTransaction(event.id);

      final list = await repo.getTransactions();
      emit(TransactionLoaded(transactions: list));
      dashboardBloc.add(const RefreshDashboard());
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}
