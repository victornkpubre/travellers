// ignore_for_file: public_member_api_docs, sort_constructors_first



import 'package:dartz/dartz.dart';

import 'package:travellers/app/app_constants.dart';
import 'package:travellers/app/functions.dart';
import 'package:travellers/data/network/failure.dart';
import 'package:travellers/data/requests/requests.dart';
import 'package:travellers/domain/entities/device_info.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:travellers/domain/usecases/base_usecase.dart';

class VerifyOtpUsecaseInput {
  String user_id;
  String otp;

  VerifyOtpUsecaseInput(
    this.user_id,
    this.otp,
  );
}

class VerifyOtpUsecase extends BaseUseCase<VerifyOtpUsecaseInput, String> {
  final Repository _repository;

  VerifyOtpUsecase(this._repository);
 

  @override
  Future<Either<Failure, String>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    
    final result = await _repository.verifyOtp(input.user_id, input.otp);
    return result;
  }

}