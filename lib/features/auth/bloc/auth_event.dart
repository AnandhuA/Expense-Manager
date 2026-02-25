part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SendOtp extends AuthEvent {
  final String phone;
  const SendOtp(this.phone);
  @override
  List<Object?> get props => [phone];
}

class VerifyOtp extends AuthEvent {
  final String otp;
  const VerifyOtp(this.otp);
  @override
  List<Object?> get props => [otp];
}

class CreateAccount extends AuthEvent {
  final String nickname;
  const CreateAccount(this.nickname);
  @override
  List<Object?> get props => [nickname];
}