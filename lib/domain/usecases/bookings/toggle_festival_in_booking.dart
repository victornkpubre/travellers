
import 'package:dartz/dartz.dart';

import 'package:travellers/data/network/failure.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class ToggleFestivalInBookingUseCaseInput {
  Booking booking;
  Festival festival;
  ToggleFestivalInBookingUseCaseInput(
    this.booking,
    this.festival,
  );
}

class ToggleFestivalInBookingUseCase extends BaseUseCase<ToggleFestivalInBookingUseCaseInput, Booking> {
  final Repository _repository;

  ToggleFestivalInBookingUseCase(this._repository);
 

  @override
  Future<Either<Failure, Booking>> execute(input) async {
    List<Festival>? festivals = input.booking.festivals;
    try {
      if( festivals == null){
        festivals = <Festival>[input.festival];
      }
      else {
        if (festivals.contains(input.festival) ){
          festivals.remove(input.festival);
        }
        else {
          festivals.add(input.festival);
        }
      }

      input.booking.festivals = festivals;
      
      return Right(input.booking);
    } catch (e) {
      return Left(Failure(-1, e.toString())); 
    }
  }

}