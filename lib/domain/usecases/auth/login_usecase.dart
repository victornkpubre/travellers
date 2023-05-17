import 'package:dartz/dartz.dart';
import 'package:travellers/app/functions.dart';
import 'package:travellers/data/network/failure.dart';
import 'package:travellers/data/requests/requests.dart';
import 'package:travellers/domain/entities/authentication.dart';
import 'package:travellers/domain/entities/device_info.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}

class LoginUseCase extends BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;

  LoginUseCase(this._repository);
 

  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    
    return await _repository.login(
      LoginRequest(input.email, input.password, deviceInfo.name)
    );
  }

}