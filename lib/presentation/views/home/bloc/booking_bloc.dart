// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:travellers/app/app_pref.dart';
import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/domain/usecases/bookings/toggle_activity_in_booking.dart';
import 'package:travellers/presentation/views/home/bloc/home_bloc.dart';

class ActivityBookingBloc extends Bloc<HomeEvent, HomeState> {
  final ToggleActivityInBookingUseCase _bookingUseCase;
  final AppPreferences _appPreferences;
  
  ActivityBookingBloc(
    this._bookingUseCase,
    this._appPreferences,
  ) : super(HomeInitial()) {
    on<GetBookingState>((event, emit) {
      _getBookingState(event);
    });
    on<ActivityBookingEvent>((event, emit) {
      _toggleActivityInBooking(event);
    });
  }

  _getBookingState(GetBookingState event) async {
    emit(BookingLoading());
    User? user = await _appPreferences.getUser();

    if(user!=null){
      Booking? booking = await _appPreferences.getBooking();
      booking ??= Booking(user.id, <Place>[], <Festival>[], <Activity>[]);
      booking.activities.contains(event.activity)? 
        emit(AddedToBooking(booking)): 
        emit(RemovedFromBooking(booking));
    }
    else {
      emit(HomeError("You need to Login"));
    }
  }

  _toggleActivityInBooking(ActivityBookingEvent event) async {
    emit(BookingLoading());
    User? user = await _appPreferences.getUser();
    if(user != null){
      Booking? booking = await _appPreferences.getBooking();
      booking ??= Booking(user.id, <Place>[], <Festival>[], <Activity>[]);
      int amountActivities = booking.activities.length;
      try {
        (await _bookingUseCase.execute(ToggleActivityInBookingUseCaseInput(booking, event.activity))).fold(
          (failure) {
            emit(HomeError(failure.message));
          }, 
          (entity) async {
            //Set booking
            await _appPreferences.setBooking(entity);
            if(amountActivities < entity.activities.length ) {
              emit(AddedToBooking(entity));
            }
            else{
              emit(RemovedFromBooking(entity));
            }
          }
        );
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    }
    else {
      emit(HomeError("You need to Login"));
    }
    
  }


}
