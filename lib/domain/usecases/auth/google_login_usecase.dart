// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:travellers/app/functions.dart';
import 'package:travellers/data/network/failure.dart';
import 'package:travellers/data/requests/requests.dart';
import 'package:travellers/domain/entities/authentication.dart';
import 'package:travellers/domain/entities/device_info.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class GoogleLoginUseCaseInput {
  String first_name; 
  String last_name;
  String email;
  String sub;

  GoogleLoginUseCaseInput(
    this.first_name,
    this.last_name,
    this.email,
    this.sub,
  );
}


class GoogleLoginUseCase extends BaseUseCase<GoogleLoginUseCaseInput, Authentication> {
  final Repository _repository;

  GoogleLoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    
    return await _repository.googleRegister(GoogleRegisterRequest(
      input.first_name, 
      input.last_name, 
      input.email, 
      input.sub
    ));
    
  }

}
  
  
  
  
  
 