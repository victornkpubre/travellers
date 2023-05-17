// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:travellers/app/app_pref.dart';
import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/domain/usecases/bookings/toggle_place_in_booking.dart';
import 'package:travellers/domain/usecases/favorites/add_favorite_place_usecase.dart';
import 'package:travellers/domain/usecases/favorites/favorite_places_usecase.dart';
import 'package:travellers/domain/usecases/favorites/remove_favorite_place_usecase.dart';
import 'package:travellers/presentation/base/toast.dart';
import 'package:travellers/presentation/views/places/bloc/places_bloc.dart';

class PlaceBookingBloc extends Bloc<PlacesEvent, PlacesState> {
  final TogglePlaceInBookingUseCase _bookingUseCase;
  final AppPreferences _appPreferences;
  
  PlaceBookingBloc(
    this._bookingUseCase,
    this._appPreferences,
  ) : super(PlacesInitial()) {
    on<GetBookingState>((event, emit) {
      _getBookingState(event);
    });

    on<BookingEvent>((event, emit) {
      _togglePlaceInBooking(event);
    });
  }


  _getBookingState(GetBookingState event) async {
    emit(PlacesLoading());
    User? user = await _appPreferences.getUser();

    if(user!=null){
      Booking? booking = await _appPreferences.getBooking();
      booking ??= Booking(user.id, <Place>[], <Festival>[], <Activity>[]);
      if(booking.places == null){
        emit(RemovedFromBooking());
      }
      else{
        booking.places.contains(event.place)? emit(AddedToBooking()): emit(RemovedFromBooking());
      }
    }
    else {
      emit(PlacesError("You need to Login"));
    }
  }

  _togglePlaceInBooking(BookingEvent event) async {
    emit(BookingLoading());
    User? user = await _appPreferences.getUser();
    if(user != null){
      Booking? booking = await _appPreferences.getBooking();
      if(booking==null){
        booking ??= Booking(user.id, <Place>[], <Festival>[], <Activity>[]);
      }
      int amountPlaces = booking.places.length;
      try {
        (await _bookingUseCase.execute(TogglePlaceInBookingUseCaseInput(booking, event.place))).fold(
          (failure) {
            emit(PlacesError(failure.message));
          }, 
          (entity) async {
            //Set booking
            await _appPreferences.setBooking(entity);
            if(booking!.places==null){
              emit(AddedToBooking());
            }
            else {
              if(amountPlaces < entity.places.length ){
                emit(AddedToBooking());
              }
              else{
                emit(RemovedFromBooking());
              }
            }
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
