// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:travellers/app/app_pref.dart';
import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/entities/emotion.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/domain/usecases/bookings/toggle_activity_in_booking.dart';
import 'package:travellers/domain/usecases/bookings/toggle_festival_in_booking.dart';
import 'package:travellers/domain/usecases/bookings/toggle_place_in_booking.dart';

part 'emotions_event.dart';
part 'emotions_state.dart';

class EmotionsBloc extends Bloc<EmotionsEvent, EmotionsState> {
  final TogglePlaceInBookingUseCase _placeBookingUseCase;
  final ToggleFestivalInBookingUseCase _festivalInBookingUseCase;
  final ToggleActivityInBookingUseCase _activityInBookingUseCase;
  final AppPreferences _appPreferences;
  
  EmotionsBloc (
    this._placeBookingUseCase,
    this._festivalInBookingUseCase,
    this._activityInBookingUseCase,
    this._appPreferences,
  ) : super(EmotionsInitial()) {
    on<GetBookingState>((event, emit) {
      _getBookingState(event);
    });

    on<BookingEvent>((event, emit) {
      _toggleEmotionInBooking(event);
    });
  }

  _getBookingState(GetBookingState event) async {
    emit(EmotionLoading());
    User? user = await _appPreferences.getUser();

    if(user!=null) {
      Booking? booking = await _appPreferences.getBooking();
      booking ??= Booking(user.id, <Place>[], <Festival>[], <Activity>[]);
      if(_emotionInBooking(booking, event.emotion)) {
        emit(AddedToBooking());
      }

      else{
        emit(RemovedFromBooking());
      }
    }
    else {
      emit(EmotionError("You need to Login"));
    }
  }

  bool _emotionInBooking(Booking booking, Emotion emotion) {
    bool booked = false;
    if(emotion.festival != null) {
      booked = booking.festivals.contains(emotion.festival)? true: false;
    }
    if(emotion.place != null) {
      booked =  booking.festivals.contains(emotion.festival)? true: false;
    }
    return booked;
  }

  _toggleEmotionInBooking(BookingEvent event) async {
    emit(EmotionLoading());
    User? user = await _appPreferences.getUser();
    if(user != null){
      Booking? booking = await _appPreferences.getBooking();
      booking ??= Booking(user.id, <Place>[], <Festival>[], <Activity>[]);

      if(event.emotion.place != null) {
        await _togglePlaceInBooking(booking, event.emotion.place!);
      }
      if(event.emotion.festival != null) {
        await _toggleFestivalInBooking(booking, event.emotion.festival!);
      }
      if(event.emotion.festival != null) {
        await _toggleActivityInBooking(booking, event.emotion.activity!);
      }
      
    }
    else {
      emit(EmotionError("You need to Login"));
    }
    
  }

  _togglePlaceInBooking(Booking booking, Place place) async {
    int amountPlaces = booking.places.length;

    (await _placeBookingUseCase.execute(TogglePlaceInBookingUseCaseInput(booking, place ))).fold(
      (failure) {
        emit(EmotionError(failure.message));
      }, 
      (entity) async {
        //Set booking
        await _appPreferences.setBooking(entity);
        if(amountPlaces < entity.places.length ){
          emit(AddedToBooking());
        }
        else{
          emit(RemovedFromBooking());
        }
      }
    );
  }

  _toggleFestivalInBooking(Booking booking, Festival festival) async {
    int amountFestivals = booking.places.length;

    (await _festivalInBookingUseCase.execute(ToggleFestivalInBookingUseCaseInput(booking, festival ))).fold(
      (failure) {
        emit(EmotionError(failure.message));
      }, 
      (entity) async {
        //Set booking
        await _appPreferences.setBooking(entity);
        if(amountFestivals < entity.places.length ){
          emit(AddedToBooking());
        }
        else{
          emit(RemovedFromBooking());
        }
      }
    );
  }

  _toggleActivityInBooking(Booking booking, Activity activity) async {
    int amountActivities = booking.activities.length;
    
    (await _activityInBookingUseCase.execute(ToggleActivityInBookingUseCaseInput(booking, activity ))).fold(
      (failure) {
        emit(EmotionError(failure.message));
      }, 
      (entity) async {
        //Set booking
        await _appPreferences.setBooking(entity);
        if(amountActivities < entity.activities.length ) {
          emit(AddedToBooking());
        }
        else{
          emit(RemovedFromBooking());
        }
      }
    );
  }


}

