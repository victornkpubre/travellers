import 'package:dartz/dartz.dart';
import 'package:travellers/app/functions.dart';
import 'package:travellers/data/network/failure.dart';
import 'package:travellers/data/requests/requests.dart';
import 'package:travellers/domain/entities/authentication.dart';
import 'package:travellers/domain/entities/device_info.dart';
import 'package:travellers/domain/entities/home_data.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class HomeDataUseCaseInput {
  HomeDataUseCaseInput();
}

class HomeDataUseCase extends BaseUseCase<HomeDataUseCaseInput, HomeDataObject> {
  final Repository _repository;

  HomeDataUseCase(this._repository);
 

  @override
  Future<Either<Failure, HomeDataObject>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    
    final result = await _repository.getHomeData();
    return result;
  }

}