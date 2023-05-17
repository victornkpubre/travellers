
import 'package:dartz/dartz.dart';

import 'package:travellers/data/network/failure.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class GetBookingsUseCase extends BaseUseCase<String, List<Booking>> {
  final Repository _repository;

  GetBookingsUseCase(this._repository);
 

  @override
  Future<Either<Failure, List<Booking>>> execute(input) async {
   
    final result = await _repository.getUserBooking(input);
    return result;
  }

}