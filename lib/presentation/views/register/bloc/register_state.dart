part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {}

class RegisterError extends RegisterState {
  String message;
  RegisterError(
    this.message,
  );

  @override 
  List<Object> get props => [message];
  
}