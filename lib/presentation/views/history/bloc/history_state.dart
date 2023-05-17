// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_bloc.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoaded extends HistoryState {
  List<Booking> bookings;
  HistoryLoaded (
    this.bookings,
  );

}

class HistoryError extends HistoryState {
  String message;
  HistoryError(
    this.message,
  );

  @override 
  List<Object> get props => [message]; 
}
