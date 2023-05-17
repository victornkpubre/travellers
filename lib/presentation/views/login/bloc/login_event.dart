// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

@immutable 
class GoogleLoginEvent extends LoginEvent {
}

@immutable
class SubmitLoginEvent extends LoginEvent{
  String email;
  String password;

  SubmitLoginEvent(
    this.email,
    this.password,
  );

  @override 
  List<Object> get props => [email, password];
}

