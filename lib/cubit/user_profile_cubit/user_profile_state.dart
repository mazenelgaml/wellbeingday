import 'package:equatable/equatable.dart';

import '../../models/user_profile_model.dart';

abstract class UserProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileSuccess extends UserProfileState {
  final String message;
  final UserProfileModel userProfile;

  UserProfileSuccess(this.message, this.userProfile);

  @override
  List<Object?> get props => [message, userProfile];
}

class UserProfileFailure extends UserProfileState {
  final String error;

  UserProfileFailure(this.error);

  @override
  List<Object?> get props => [error];
}
