// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteEvent {}

class GetFavoritesEvent extends FavoriteEvent {
  int id;
  GetFavoritesEvent(
    this.id,
  );

  @override 
  List<Object> get props => [id];
  
}

class RemoveFavoriteEvent extends FavoriteEvent {}

class AddFavoriteEvent extends FavoriteEvent {}