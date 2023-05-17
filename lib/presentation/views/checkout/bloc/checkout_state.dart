// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {

}

class CheckoutCompleted extends CheckoutState {
  String message;
  CheckoutCompleted(
    this.message,
  );

  @override 
  List<Object> get props => [message];
}


class CheckoutLoaded extends CheckoutState {
  List<Place>? places;
  List<Festival>? festivals;
  List<Activity>? activities;
  CheckoutLoaded(
    this.places,
    this.festivals,
    this.activities,
  );

  @override 
  List<Object> get props => [places??<Place>[], festivals??<Place>[], activities??<Place>[]];
}

class CheckoutError extends CheckoutState {
  String message;
  CheckoutError(
    this.message,
  );

  @override 
  List<Object> get props => [message]; 
}

