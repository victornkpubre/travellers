import 'package:dartz/dartz.dart';
import 'package:travellers/app/functions.dart';
import 'package:travellers/data/network/failure.dart';
import 'package:travellers/data/requests/requests.dart';
import 'package:travellers/domain/entities/authentication.dart';
import 'package:travellers/domain/entities/device_info.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class LogoutUseCaseInput {
}

class LogoutUseCase extends BaseUseCase<LogoutUseCaseInput, int> {
  final Repository _repository;

  LogoutUseCase(this._repository);
 

  @override
  Future<Either<Failure, int>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.logout();
  }

}