part of 'emotions_bloc.dart';

@immutable
abstract class EmotionsState {}

class EmotionsInitial extends EmotionsState {}

class EmotionLoading extends EmotionsState {

}

class EmotionError extends EmotionsState {
  String message;
  EmotionError(
    this.message,
  );

  @override 
  List<Object> get props => [message];
}

class EmotionLoaded extends EmotionsState {}

class AddedToBooking extends EmotionsState {}

class RemovedFromBooking extends EmotionsState {}
