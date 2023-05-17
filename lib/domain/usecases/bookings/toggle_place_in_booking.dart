
import 'package:dartz/dartz.dart';

import 'package:travellers/data/network/failure.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class TogglePlaceInBookingUseCaseInput {
  Booking booking;
  Place place;
  TogglePlaceInBookingUseCaseInput(
    this.booking,
    this.place,
  );
}

class TogglePlaceInBookingUseCase extends BaseUseCase<TogglePlaceInBookingUseCaseInput, Booking> {
  final Repository _repository;

  TogglePlaceInBookingUseCase(this._repository);
 

  @override
  Future<Either<Failure, Booking>> execute(input) async {
    List<Place>? places = input.booking.places;
    try {
      if( places == null){
        places = <Place>[input.place];
      }
      else {
        if (places.contains(input.place) ){
          places.remove(input.place);
        }
        else {
          places.add(input.place);
        }
      }

      input.booking.places = places;
      
      return Right(input.booking);
    } catch (e) {
      return Left(Failure(-1, e.toString())); 
    }
  }

}