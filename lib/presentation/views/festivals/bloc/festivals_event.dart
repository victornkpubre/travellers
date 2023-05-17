// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'festivals_bloc.dart';

@immutable
abstract class FestivalsEvent {}

@immutable
class GetFavoriteFestival extends FestivalsEvent {
  Festival festival;
  GetFavoriteFestival({
    required this.festival,
  });

  @override 
  List<Object> get props => [festival];
}

@immutable
class AddFavoriteFestival extends FestivalsEvent {
  Festival festival;
  AddFavoriteFestival({
    required this.festival,
  });

  @override 
  List<Object> get props => [festival];
}

@immutable
class RemoveFavoriteFestival extends FestivalsEvent {
  Festival festival;
  RemoveFavoriteFestival({
    required this.festival,
  });

  @override 
  List<Object> get props => [festival];
}

@immutable
class GetBookingState extends FestivalsEvent {
  Festival festival;
  GetBookingState({
    required this.festival,
  });

  @override 
  List<Object> get props => [festival];
}

@immutable
class BookingEvent extends FestivalsEvent {
  Festival festival;
  BookingEvent(
    this.festival,
  );

  @override 
  List<Object> get props => [festival];
}
