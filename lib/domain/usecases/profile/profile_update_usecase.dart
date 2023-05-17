// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:dartz/dartz.dart';

import 'package:travellers/app/app_constants.dart';
import 'package:travellers/app/functions.dart';
import 'package:travellers/data/network/failure.dart';
import 'package:travellers/data/requests/requests.dart';
import 'package:travellers/domain/entities/device_info.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class UpdateProfileUsecaseInput {
  String user_id;
  String first_name;
  String last_name;
  String email;
  String phone;

  UpdateProfileUsecaseInput(
    this.user_id,
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
  );
}

class UpdateProfileUsecase extends BaseUseCase<UpdateProfileUsecaseInput, String> {
  final Repository _repository;

  UpdateProfileUsecase(this._repository);
 

  @override
  Future<Either<Failure, String>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    
    final result = await _repository.updateProfile(UpdateProfileRequest(
      user_id: input.user_id,
      first_name: input.first_name, 
      last_name: input.last_name, 
      email: input.email, 
      phone: input.phone,
    ));
    return result;
  }

}