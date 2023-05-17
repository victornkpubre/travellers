// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'places_bloc.dart';

@immutable
abstract class PlacesEvent {}

@immutable
class GetFavoritePlace extends PlacesEvent {
  Place place;
  GetFavoritePlace({
    required this.place,
  });

  @override 
  List<Object> get props => [place];
}


@immutable
class GetBookingState extends PlacesEvent {
  Place place;
  GetBookingState({
    required this.place,
  });

  @override 
  List<Object> get props => [place];
}


@immutable
class AddFavoritePlace extends PlacesEvent {
  Place place;
  AddFavoritePlace({
    required this.place,
  });

  @override 
  List<Object> get props => [place];
}

@immutable
class RemoveFavoritePlace extends PlacesEvent {
  Place place;
  RemoveFavoritePlace({
    required this.place,
  });

  @override 
  List<Object> get props => [place];
}

@immutable
class BookingEvent extends PlacesEvent {
  Place place;
  BookingEvent(
    this.place,
  );

  @override 
  List<Object> get props => [place];
}
