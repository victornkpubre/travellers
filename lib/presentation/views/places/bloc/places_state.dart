// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'places_bloc.dart';

@immutable
abstract class PlacesState {}

class PlacesInitial extends PlacesState {}

class PlaceAdded extends PlacesState {}

class PlaceRemoved extends PlacesState {}

class PlacesLoading extends PlacesState {}

class BookingLoading extends PlacesState {}

class AddedToBooking extends PlacesState {}

class RemovedFromBooking extends PlacesState {}

class PlacesError extends PlacesState {
  String message;
  PlacesError(
    this.message,
  );

  @override 
  List<Object> get props => [message];
}
