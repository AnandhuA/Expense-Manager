import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:expense_manager/core/services/preference_service.dart';
import 'package:expense_manager/features/auth/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repo = AuthRepository();
  final PreferencesService preferencesService = PreferencesService();
  bool userExists = false;
  String? phone;
  String? otp;

  AuthBloc() : super(AuthInitial()) {
    on<SendOtp>(_sentOtp);
    on<VerifyOtp>(_verifyOtp);
    on<CreateAccount>(_createAccount);
  }

  FutureOr<void> _sentOtp(SendOtp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final res = await repo.sendOtp(event.phone);
      if (res.token != null) {
        await preferencesService.saveToken(res.token!);
      }
      if (res.nickname != null) {
        await preferencesService.saveNickname(res.nickname!);
      }

      userExists = res.userExists;
      phone = event.phone;
      otp = res.otp;

      emit(OtpSent(userExists: userExists, otp: otp));
    } catch (e) {
      log("Error $e");
      emit(AuthError(e.toString()));
    }
  }

  FutureOr<void> _verifyOtp(VerifyOtp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (otp != null && otp == event.otp) {
      if (userExists) {
        emit(Authenticated());
      } else {
        emit(NeedNickname());
      }
    } else {
      emit(AuthError("Invalid OTP"));
    }
  }

  FutureOr<void> _createAccount(
    CreateAccount event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final res = await repo.createAccount(phone ?? "", event.nickname);
      if (res.token != null) {
        await preferencesService.saveToken(res.token!);
      }
      if (res.nickname != null) {
        await preferencesService.saveNickname(res.nickname!);
      }

      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
