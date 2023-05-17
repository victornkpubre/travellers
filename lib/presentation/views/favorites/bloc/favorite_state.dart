// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  List<Place> places;
  List<Festival> festivals;
  FavoriteLoaded(
    this.places,
    this.festivals,
  );

  @override 
  List<Object> get props => [places, festivals];
}

class FavoriteError extends FavoriteState {
  String message;
  FavoriteError(
    this.message,
  );

  @override 
  List<Object> get props => [message]; 
}