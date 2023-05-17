// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

@immutable 
class GoogleLoginEvent extends RegisterEvent {
}

@immutable
class SubmitRegisterEvent extends RegisterEvent {
  String first_name; 
  String last_name; 
  String email; 
  String password; 
  String phone; 
  

  SubmitRegisterEvent(
    this.first_name,
    this.last_name,
    this.email,
    this.password,
    this.phone,
  );

  @override 
  List<Object> get props => [first_name, last_name, email, password, phone];
}
