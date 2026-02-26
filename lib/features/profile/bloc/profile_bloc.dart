import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:expense_manager/core/services/storage/preference_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final PreferencesService preferences = PreferencesService();

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>(_loadProfile);
    on<UpdateAlertLimit>(_updateAlertLimit);
    on<UpdateNickname>(_updateNickname);
  }

  FutureOr<void> _loadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final nickname = preferences.nickname ?? "User";
    final limit = preferences.alertLimit;

    emit(ProfileLoaded(nickname: nickname, alertLimit: limit));
  }

  FutureOr<void> _updateAlertLimit(
    UpdateAlertLimit event,
    Emitter<ProfileState> emit,
  ) async {
    await preferences.saveAlertLimit(event.limit);

    final nickname = preferences.nickname ?? "User";

    emit(ProfileLoaded(nickname: nickname, alertLimit: event.limit));
  }

  FutureOr<void> _updateNickname(
    UpdateNickname event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    await preferences.saveNickname(event.nickname);
    final limit = preferences.alertLimit;

    emit(ProfileLoaded(nickname: event.nickname, alertLimit: limit));
  }
}
