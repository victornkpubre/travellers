// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:travellers/app/app_pref.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/domain/usecases/bookings/toggle_place_in_booking.dart';
import 'package:travellers/domain/usecases/favorites/add_favorite_place_usecase.dart';
import 'package:travellers/domain/usecases/favorites/favorite_places_usecase.dart';
import 'package:travellers/domain/usecases/favorites/remove_favorite_place_usecase.dart';
import 'package:travellers/presentation/base/toast.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final AddFavoritePlaceUseCase _addFavoritePlaceUseCase;
  final RemoveFavoritePlaceUseCase _removeFavoritePlaceUseCase;
  final FavoritePlacesUseCase _favoritePlacesUseCase;
  final AppPreferences _appPreferences;
  
  PlacesBloc(
    this._addFavoritePlaceUseCase,
    this._removeFavoritePlaceUseCase,
    this._favoritePlacesUseCase,
    this._appPreferences,
  ) : super(PlacesInitial()) {
    on<GetFavoritePlace>((event, emit) {
      _getFavoriteState(event);
    });
    on<AddFavoritePlace>((event, emit) {
      _addFavoritePlace(event);
    });
    on<RemoveFavoritePlace>((event, emit) {
      _removeFavoritePlace(event);
    });
  }

  _getFavoriteState(GetFavoritePlace event) async {
    emit(PlacesLoading());
    User? user = await _appPreferences.getUser();
    if(user!=null){
      try {
        (await _favoritePlacesUseCase.execute(FavoritePlacesUseCaseInput(user.id.toString()))).fold(
          (failure) {
            emit(PlacesError(failure.message));
          }, 
          (entity) {
            entity.contains(event.place)?
            emit(PlaceAdded()):
            emit(PlaceRemoved());
          }
        );
      } catch (e) {
        emit(PlacesError(e.toString()));
      }
    }
    else {
      emit(PlacesError("You need to Login"));
    }
  }

  _addFavoritePlace(AddFavoritePlace event) async {
    emit(PlacesLoading());
    User? user = await _appPreferences.getUser();
    if(user!=null){
      try {
        (await _addFavoritePlaceUseCase.execute(AddFavoritePlaceUseCaseInput(user.id.toString(), event.place.id.toString()))).fold(
          (failure) {
            emit(PlacesError(failure.message));
          }, 
          (entity) {
            emit(PlaceAdded());
          }
        );
      } catch (e) {
        emit(PlacesError(e.toString()));
      }
    }
    else {
      emit(PlacesError("You need to Login"));
    }
  }

  _removeFavoritePlace(RemoveFavoritePlace event) async {
    emit(PlacesLoading());
    User? user = await _appPreferences.getUser();
    if(user!=null){
      try {
        (await _removeFavoritePlaceUseCase.execute(RemoveFavoritePlaceUseCaseInput(user.id.toString(), event.place.id.toString()))).fold(
          (failure) {
            emit(PlacesError(failure.message));
          }, 
          (entity) {
            emit(PlaceRemoved());
          }
        );
      } catch (e) {
        emit(PlacesError(e.toString()));
      }
    }
    else {
      emit(PlacesError("You need to Login"));
    }
  }

}
