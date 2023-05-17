part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

@immutable
class GetDataEvent extends HomeEvent {}

class LogoutEvent extends HomeEvent {}

@immutable
class GetBookingState extends HomeEvent {
  Activity activity;
  GetBookingState(
    this.activity,
  );

  @override 
  List<Object> get props => [activity];
}

@immutable
class ActivityBookingEvent extends HomeEvent {
  Activity activity;
  ActivityBookingEvent(
    this.activity,
  );

  @override 
  List<Object> get props => [activity];
}

