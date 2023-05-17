// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:travellers/data/network/failure.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class FavoritePlacesUseCaseInput {
  String id;
  FavoritePlacesUseCaseInput(
    this.id,
  );
}

class FavoritePlacesUseCase extends BaseUseCase<FavoritePlacesUseCaseInput, List<Place>> {
  final Repository _repository;

  FavoritePlacesUseCase(this._repository);
 

  @override
  Future<Either<Failure, List<Place>>> execute(input) async {
   
    final result = await _repository.getUserPlaces(input.id);
    return result;
  }

}