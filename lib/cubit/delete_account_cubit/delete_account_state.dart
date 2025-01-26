import 'package:equatable/equatable.dart';

abstract class DeleteAccountState extends Equatable {
  @override
  List<Object?> get props => [];
}

class  DeleteAccountInitial extends DeleteAccountState {}

class  DeleteAccountLoading extends DeleteAccountState {}

class  DeleteAccountSuccess extends DeleteAccountState {
  final String message;

  DeleteAccountSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class  DeleteAccountFailure extends  DeleteAccountState {
  final String error;

  DeleteAccountFailure(this.error);

  @override
  List<Object?> get props => [error];
}
