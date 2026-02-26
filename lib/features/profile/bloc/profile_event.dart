part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateAlertLimit extends ProfileEvent {
  final double limit;

  const UpdateAlertLimit(this.limit);

  @override
  List<Object?> get props => [limit];
}

class UpdateNickname extends ProfileEvent {
  final String nickname;
  const UpdateNickname(this.nickname);

  @override
  List<Object?> get props => [nickname];
}
