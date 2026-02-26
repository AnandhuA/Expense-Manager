part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

final class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final double totalIncome;
  final double totalExpense;
  final String name ;
  final List<TransactionWithCategoryModel> recentTransactions;

  const DashboardLoaded({
    required this.totalIncome,
    required this.totalExpense,
    required this.recentTransactions,
    required this.name
  });

  @override
  List<Object?> get props => [totalIncome, totalExpense, recentTransactions];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
