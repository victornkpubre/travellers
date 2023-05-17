// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

class GetHistory extends HistoryEvent {
  int user_id;
  GetHistory(
    this.user_id,
  );
}
