
import 'package:dartz/dartz.dart';

import 'package:travellers/data/network/failure.dart';
import 'package:travellers/data/requests/requests.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class BookingUseCaseInput {
  String user_id;
  Booking booking;
  BookingUseCaseInput(
    this.user_id,
    this.booking,
  );
}

class BookingUseCase extends BaseUseCase<BookingUseCaseInput, String> {
  final Repository _repository;

  BookingUseCase(this._repository);
 

  @override
  Future<Either<Failure, String>> execute(input) async {
    List<int> places = input.booking.places.map((e) => e.id).toList();
    List<int> festivals = input.booking.festivals.map((e) => e.id).toList();
    List<int> activities = input.booking.activities.map((e) => e.id).toList();

    final result =  _repository.placeBooking(BookingRequest(input.user_id, places, festivals, activities));
    return result;
  }

}