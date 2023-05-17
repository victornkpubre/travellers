part of 'emotions_bloc.dart';

@immutable
abstract class EmotionsEvent {}

@immutable
class GetBookingState extends EmotionsEvent {
  Emotion emotion;
  GetBookingState(
    this.emotion,
  );

  @override 
  List<Object> get props => [emotion];
}

@immutable
class BookingEvent extends EmotionsEvent {
  Emotion emotion;
  BookingEvent(
    this.emotion,
  );

  @override 
  List<Object> get props => [emotion];
}