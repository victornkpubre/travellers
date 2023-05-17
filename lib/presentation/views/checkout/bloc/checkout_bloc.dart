// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:travellers/app/app_pref.dart';

import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/domain/usecases/bookings/place_booking_usecase.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final BookingUseCase _bookingUsecase;
  final AppPreferences _appPreferences;

  CheckoutBloc(
    this._bookingUsecase,
    this._appPreferences,
  ) : super(CheckoutInitial()) {
    on<GetCheckout>((event, emit) {
      _getCheckoutBooking();
    });
    on<PlaceBooking>((event, emit) {
      _placeBooking(event);
    });
  }

  _getCheckoutBooking() async {
    emit(CheckoutLoading());
    User? user = await _appPreferences.getUser();

    if(user!=null){
      Booking? booking = await _appPreferences.getBooking();
      booking ??= Booking(user.id, <Place>[], <Festival>[], <Activity>[]);
      emit(CheckoutLoaded(booking.places, booking.festivals, booking.activities));
    }
    else {
      emit(CheckoutError("You need to Login"));
    }
  }

  _placeBooking(PlaceBooking event) async {
    try {
      int user_id = event.user.id;
      Booking? booking = await _appPreferences.getBooking();
      booking ??= Booking(user_id, <Place>[], <Festival>[], <Activity>[]);
      (await _bookingUsecase.execute(BookingUseCaseInput(user_id.toString(), booking))).fold(
        (failure) {
          emit(CheckoutError(failure.message));
        }, 
        (entity) async {
          //clear cart
          _appPreferences.setBooking(null);
          emit(CheckoutCompleted(entity));
        }
      );
    } catch (e) {
      emit(CheckoutError(e.toString()));
    }
  }


}
