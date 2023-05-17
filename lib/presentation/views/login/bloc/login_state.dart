// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  const LoginState();

  @override 
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {}

class LoginError extends LoginState {
  String message;
  LoginError(
    this.message,
  );

  @override 
  List<Object> get props => [message];
  
}

