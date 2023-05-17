// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:travellers/app/app_pref.dart';
import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/domain/usecases/bookings/toggle_festival_in_booking.dart';
import 'package:travellers/presentation/views/festivals/bloc/festivals_bloc.dart';

class FestivalBookingBloc extends Bloc<FestivalsEvent, FestivalsState> {
  final ToggleFestivalInBookingUseCase _bookingUseCase;
  final AppPreferences _appPreferences;
  
  FestivalBookingBloc (
    this._bookingUseCase,
    this._appPreferences,
  ) : super(FestivalsInitial()) {
    on<GetBookingState>((event, emit) {
      _getBookingState(event);
    });

    on<BookingEvent>((event, emit) {
      _toggleFestivalInBooking(event);
    });
  }


  _getBookingState(GetBookingState event) async {
    emit(FestivalsLoading());
    User? user = await _appPreferences.getUser();

    if(user!=null){
      Booking? booking = await _appPreferences.getBooking();
      booking ??= Booking(user.id, <Place>[], <Festival>[], <Activity>[]);
      if(booking.festivals == null){
        emit(RemovedFromBooking());
      }
      else{
        booking.festivals.contains(event.festival)? emit(AddedToBooking()): emit(RemovedFromBooking());
      }
    }
    else {
      emit(FestivalsError("You need to Login"));
    }
  }

  _toggleFestivalInBooking(BookingEvent event) async {
    emit(BookingLoading());
    User? user = await _appPreferences.getUser();
    if(user != null){
      Booking? booking = await _appPreferences.getBooking();
      booking ??= Booking(user.id, <Place>[], <Festival>[], <Activity>[]);
      int amountFestivals = booking.festivals.length;
      try {
        (await _bookingUseCase.execute(ToggleFestivalInBookingUseCaseInput(booking, event.festival))).fold(
          (failure) {
            emit(FestivalsError(failure.message));
          }, 
          (entity) async {
            //Set booking
            await _appPreferences.setBooking(entity);
            if(booking!.festivals==null){
              emit(AddedToBooking());
            }
            else {
              if(amountFestivals < entity.festivals.length ){
                emit(AddedToBooking());
              }
              else{
                emit(RemovedFromBooking());
              }
            }
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
