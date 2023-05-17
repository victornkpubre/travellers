part of 'festivals_bloc.dart';

@immutable
abstract class FestivalsState {}

class FestivalsInitial extends FestivalsState {}

class BookingLoading extends FestivalsState {}

class AddedToBooking extends FestivalsState {}

class RemovedFromBooking extends FestivalsState {}

class FestivalAdded extends FestivalsState {}

class FestivalRemoved extends FestivalsState {}

class FestivalsLoaded extends FestivalsState {}

class FestivalsLoading extends FestivalsState {}

class FestivalsError extends FestivalsState {
  String message;
  FestivalsError(
    this.message,
  );

  @override 
  List<Object> get props => [message];
}