// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import 'package:travellers/data/network/failure.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class RemoveFavoritePlaceUseCaseInput {
  String user_id;
  String place_id;
  RemoveFavoritePlaceUseCaseInput(
    this.user_id,
    this.place_id,
  );
}

class RemoveFavoritePlaceUseCase extends BaseUseCase<RemoveFavoritePlaceUseCaseInput, String> {
  final Repository _repository;

  RemoveFavoritePlaceUseCase(this._repository);
 

  @override
  Future<Either<Failure, String>> execute(input) async {
   
    final result =  _repository.removeFavoritePlace(input.user_id, input.place_id);
    return result;
  }

}