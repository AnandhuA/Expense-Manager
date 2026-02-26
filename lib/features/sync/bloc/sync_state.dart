part of 'sync_bloc.dart';

sealed class SyncState extends Equatable {
  const SyncState();

  @override
  List<Object?> get props => [];
}

final class SyncInitial extends SyncState {}

class SyncInProgress extends SyncState {}

class SyncSuccess extends SyncState {}

class SyncFailure extends SyncState {
  final String message;
  const SyncFailure(this.message);

  @override
  List<Object?> get props => [message];
}
