abstract class SignUpSpecialistState {}

 class SignUpSpecialistInitial extends SignUpSpecialistState {}

 class SignUpSpecialistLoading extends SignUpSpecialistState {
  final String message;

  SignUpSpecialistLoading({required this.message});
}

 class SignUpSpecialistSuccess extends SignUpSpecialistState {
  final String message;

  SignUpSpecialistSuccess({required this.message});
}

 class SignUpSpecialistFailure extends SignUpSpecialistState {
  final String errMessage;
  SignUpSpecialistFailure({required this.errMessage});
}
