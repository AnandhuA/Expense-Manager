part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class OtpSent extends AuthState {
  final bool userExists;
  final String? otp;
  const OtpSent({required this.userExists, required this.otp});
}

class NeedNickname extends AuthState {}

class Authenticated extends AuthState {}
class AuthLoggedOut extends AuthState {} 

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}


class ProfileLoaded extends AuthState {
  final String nickname;

  const ProfileLoaded(this.nickname);

  @override
  List<Object?> get props => [nickname];
}