// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutEvent {}

class GetCheckout extends CheckoutEvent {

}

class PlaceBooking extends CheckoutEvent {
  User user;

  PlaceBooking(
    this.user,
  );

  @override 
  List<Object> get props => [user];
}

