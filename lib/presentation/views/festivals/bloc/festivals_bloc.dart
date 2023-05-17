// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:travellers/app/app_pref.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/domain/usecases/favorites/add_favorite_festival_usecase.dart';
import 'package:travellers/domain/usecases/favorites/favorite_festivals_usecase.dart';
import 'package:travellers/domain/usecases/favorites/remove_favorite_festival_usecase.dart';

part 'festivals_event.dart';
part 'festivals_state.dart';

class FestivalsBloc extends Bloc<FestivalsEvent, FestivalsState> {
  final AddFavoriteFestivalUseCase _addFavoriteFestivalUseCase;
  final RemoveFavoriteFestivalUseCase _removeFavoriteFestivalUseCase;
  final FavoriteFestivalsUseCase _favoriteFestivalsUseCase;
  final AppPreferences _appPreferences;

  FestivalsBloc(
    this._addFavoriteFestivalUseCase,
    this._removeFavoriteFestivalUseCase,
    this._favoriteFestivalsUseCase,
    this._appPreferences,
  ) : super(FestivalsInitial()) {
    on<GetFavoriteFestival>((event, emit) {
      _getFavoriteState(event);
    });
    on<AddFavoriteFestival>((event, emit) {
      _addFavoriteFestival(event);
    });
    on<RemoveFavoriteFestival>((event, emit) {
      _removeFavoriteFestival(event);
    });
  }

  _getFavoriteState(GetFavoriteFestival event) async {
    emit(FestivalsLoading());
    User? user = await _appPreferences.getUser();
    if(user!=null){
      try {
        (await _favoriteFestivalsUseCase.execute(FavoriteFestivalsUseCaseInput(user.id.toString()))).fold(
          (failure) {
            emit(FestivalsError(failure.message));
          }, 
          (entity) {
            entity.contains(event.festival)?
            emit(FestivalAdded()):
            emit(FestivalRemoved());
          }
        );
      } catch (e) {
        emit(FestivalsError(e.toString()));
      }
    }
    else {
      emit(FestivalsError("You need to Login"));
    }
  }

  _addFavoriteFestival(AddFavoriteFestival event) async {
    emit(FestivalsLoading());
    User? user = await _appPreferences.getUser();
    if(user!=null){
      try {
        (await _addFavoriteFestivalUseCase.execute(AddFavoriteFestivalUseCaseInput(user.id.toString(), event.festival.id.toString()))).fold(
          (failure) {
            emit(FestivalsError(failure.message));
          }, 
          (entity) {
            emit(FestivalAdded());
          }
        );
      } catch (e) {
        emit(FestivalsError(e.toString()));
      }
    }
    else {
      emit(FestivalsError("You need to Login"));
    }
  }

  _removeFavoriteFestival(RemoveFavoriteFestival event) async {
    emit(FestivalsLoading());
    User? user = await _appPreferences.getUser();
    if(user!=null){
      try {
        (await _removeFavoriteFestivalUseCase.execute(RemoveFavoriteFestivalUseCaseInput(user.id.toString(), event.festival.id.toString()))).fold(
          (failure) {
            emit(FestivalsError(failure.message));
          }, 
          (entity) {
            emit(FestivalRemoved());
          }
        );
      } catch (e) {
        emit(FestivalsError(e.toString()));
      }
    }
    else {
      emit(FestivalsError("You need to Login"));
    }
  }



}
