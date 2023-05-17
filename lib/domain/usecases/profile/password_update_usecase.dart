// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:dartz/dartz.dart';

import 'package:travellers/app/app_constants.dart';
import 'package:travellers/app/functions.dart';
import 'package:travellers/data/network/failure.dart';
import 'package:travellers/data/requests/requests.dart';
import 'package:travellers/domain/entities/device_info.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class UpdatePasswordUsecaseInput {
  String email;
  String password;
  String new_password;

  UpdatePasswordUsecaseInput(
    this.email,
    this.password,
    this.new_password,
  );
}

class UpdatePasswordUsecase extends BaseUseCase<UpdatePasswordUsecaseInput, String> {
  final Repository _repository;

  UpdatePasswordUsecase(this._repository);
 

  @override
  Future<Either<Failure, String>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    
    final result = await _repository.updatePassword( UpdateProfileRequest(
      email: input.email,
      password: input.password,
      new_password: input.new_password,
    ));
    return result;
  }

}