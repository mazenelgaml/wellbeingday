import 'dart:io';

abstract class AddImageToProfileState {}

class AddImageToProfileInitial extends AddImageToProfileState {}

class AddImageToProfileLoading extends AddImageToProfileState {}

class AddImageToProfileImageSelected extends AddImageToProfileState {
  final File imageFile;

  AddImageToProfileImageSelected(this.imageFile);
}

class AddImageToProfileSuccess extends AddImageToProfileState {
  final String message;

  AddImageToProfileSuccess(this.message);
}

class AddImageToProfileFailure extends AddImageToProfileState {
  final String message;

  AddImageToProfileFailure(this.message);
}
