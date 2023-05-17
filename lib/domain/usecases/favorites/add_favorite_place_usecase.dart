// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import 'package:travellers/data/network/failure.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class AddFavoritePlaceUseCaseInput {
  String user_id;
  String place_id;
  AddFavoritePlaceUseCaseInput(
    this.user_id,
    this.place_id,
  );
}

class AddFavoritePlaceUseCase extends BaseUseCase<AddFavoritePlaceUseCaseInput, String> {
  final Repository _repository;

  AddFavoritePlaceUseCase(this._repository);
 

  @override
  Future<Either<Failure, String>> execute(input) async {
   
    final result =  _repository.addFavoritePlace(input.user_id, input.place_id);
    return result;
  }

}