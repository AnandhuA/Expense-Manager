import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_manager/features/sync/repository/sync_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sync_event.dart';
part 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
    final SyncRepository repo = SyncRepository();
  SyncBloc() : super(SyncInitial()) {
    on<StartSync>(_startSync);
  }

  FutureOr<void> _startSync(StartSync event, Emitter<SyncState> emit) async{

      emit(SyncInProgress());

    try {
      await repo.syncDeletedTransactions();
      await repo.syncDeletedCategories();

      await repo.syncCategories();
      await repo.syncTransactions();

      emit(SyncSuccess());
    } catch (e) {
      emit(SyncFailure(e.toString()));
    }
  }
}
