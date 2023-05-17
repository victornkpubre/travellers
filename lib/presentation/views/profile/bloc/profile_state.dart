part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {}

class ProfileUpdated extends ProfileState {
  User user;
  ProfileUpdated(
    this.user,
  );

  @override 
  List<Object> get props => [user];
}

class PhoneVerified extends ProfileState {
  String message;
  PhoneVerified(
    this.message,
  );

  @override 
  List<Object> get props => [message];
}

class OtpVerified extends ProfileState {
  String message;
  OtpVerified(
    this.message,
  );

  @override 
  List<Object> get props => [message];
}


class ProfileError extends ProfileState {
  String message;
  ProfileError(
    this.message,
  );

  @override 
  List<Object> get props => [message];
  
}

