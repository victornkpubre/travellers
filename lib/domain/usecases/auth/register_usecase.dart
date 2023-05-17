import 'package:dartz/dartz.dart';
import 'package:travellers/app/functions.dart';
import 'package:travellers/data/network/failure.dart';
import 'package:travellers/data/requests/requests.dart';
import 'package:travellers/domain/entities/authentication.dart';
import 'package:travellers/domain/entities/device_info.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class RegisterUseCaseInput {
  String first_name;
  String last_name;
  String email;
  String phone;
  String password;

  RegisterUseCaseInput(
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.password,
  );
}


class RegisterUseCase extends BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    
    return await _repository.register(
      RegisterRequest (
        input.first_name, 
        input.last_name, 
        input.email, 
        input.password, 
        input.phone, 
        deviceInfo.name
      )
    );
  }

}