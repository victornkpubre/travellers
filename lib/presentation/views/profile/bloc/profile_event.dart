// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

@immutable
class UpdateProfileEvent extends ProfileEvent {
  String user_id;
  String first_name;
  String last_name;
  String email;
  String phone;
  int is_phone_verified;
  

  UpdateProfileEvent(
    this.user_id,
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.is_phone_verified,
  );

  @override 
  List<Object> get props => [first_name, last_name, email, phone, is_phone_verified];
}

@immutable
class VerifyPhoneEvent extends ProfileEvent {
  String user_id;
  String phone;
  VerifyPhoneEvent(
    this.user_id,
    this.phone,
  );

  @override 
  List<Object> get props => [user_id, phone];
}

@immutable
class VerifyOtpEvent extends ProfileEvent {
  String user_id;
  String otp;
  VerifyOtpEvent(
    this.user_id,
    this.otp,
  );

  @override 
  List<Object> get props => [user_id, otp];
}

@immutable
class ResetPasswordEvent extends ProfileEvent {
  String email;
  String password;
  String new_password;

  ResetPasswordEvent(
    this.email,
    this.password,
    this.new_password,
  );

  @override 
  List<Object> get props => [email, password, new_password];
}
