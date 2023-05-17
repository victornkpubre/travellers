
import 'package:dartz/dartz.dart';
import 'package:travellers/data/network/failure.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class FavoriteFestivalsUseCaseInput {
  String id;
  FavoriteFestivalsUseCaseInput(
    this.id,
  );
}

class FavoriteFestivalsUseCase extends BaseUseCase<FavoriteFestivalsUseCaseInput, List<Festival>> {
  final Repository _repository;

  FavoriteFestivalsUseCase(this._repository);
 

  @override
  Future<Either<Failure, List<Festival>>> execute(input) async {
   
    final result =  _repository.getUserFestivals(input.id);
    return result;
  }

}