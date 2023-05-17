// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:travellers/app/app_pref.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/usecases/favorites/favorite_festivals_usecase.dart';
import 'package:travellers/domain/usecases/favorites/favorite_places_usecase.dart';
import 'package:travellers/domain/usecases/home_data_usecase.dart';
import 'package:travellers/presentation/views/home/tabs/places.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoritePlacesUseCase _getPlacesUsecase;
  FavoriteFestivalsUseCase _getFlestivalsUsecase;
  AppPreferences _appPreferences;


  FavoriteBloc(
    this._getFlestivalsUsecase,
    this._getPlacesUsecase,
    this._appPreferences,
  ) : super(FavoriteInitial()) {
    on<GetFavoritesEvent>((event, emit) async {
      emit(FavoriteLoading());
      List<Festival> festivals = await _getFavoriteFestivals(event.id.toString());
      List<Place> places = await _getFavoritePlaces(event.id.toString());
      emit(FavoriteLoaded(places, festivals));
    });
  }


  Future<List<Festival>> _getFavoriteFestivals(String id) async {
    List<Festival> festivals = [];
    try {
      (await _getFlestivalsUsecase.execute(FavoriteFestivalsUseCaseInput(id))).fold(
        (failure) {
          print(failure.code);
          emit(FavoriteError(failure.message));
        }, 
        (entity) {
          //Store token
          festivals = entity;
        }
      );
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }

    return festivals;

  }


  Future<List<Place>> _getFavoritePlaces(String id) async {
    List<Place> places = [];
    try {
      (await _getPlacesUsecase.execute(FavoritePlacesUseCaseInput(id))).fold(
        (failure) {
          print(failure.code);
          emit(FavoriteError(failure.message));
        }, 
        (entity) {
          //Store token
          places = entity;
        }
      );
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }

    return places;

  }


}
