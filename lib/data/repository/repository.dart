

import 'package:dio/dio.dart';
import 'package:travellers/app/app_constants.dart';
import 'package:travellers/data/data_source/remote_data_source.dart';
import 'package:travellers/data/mappers/mapper.dart';
import 'package:travellers/data/network/error_handler.dart';
import 'package:travellers/data/network/network_info.dart';
import 'package:travellers/data/responses/responses.dart';
import 'package:travellers/domain/entities/authentication.dart';
import 'package:travellers/data/requests/requests.dart';
import 'package:travellers/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/home_data.dart';
import 'package:travellers/domain/entities/place.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/domain/repository/repository.dart';

class RepositoryImplementation extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImplementation(this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected){
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.toDomain());
        }
        else {

          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRquest) async {
    if(await _networkInfo.isConnected){
      try {
        final response = await _remoteDataSource.register(registerRquest);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.toDomain());
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        // var e = (error. as DioError);
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, Authentication>> googleRegister(GoogleRegisterRequest registerRquest) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.googleRegister(registerRquest);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.toDomain());
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        // var e = (error. as DioError);
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, HomeDataObject>> getHomeData() async {
    if(await _networkInfo.isConnected){
      try {
        final response = await _remoteDataSource.getHomeData();
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.toDomain());
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError){
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

  
  @override
  Future<Either<Failure, String>> updatePassword(UpdateProfileRequest input) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.updatePassword(input);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.message!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        
        if(error is DioError){
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
        
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }
  

  @override
  Future<Either<Failure, String>> updateProfile(UpdateProfileRequest input) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.updateProfile(input);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.message!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null){
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }


  @override
  Future<Either<Failure, String>> addFavoriteFestival(String client_id, String festival_id) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.addFavoriteFestival(client_id, festival_id);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.message!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null){
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }


  @override
  Future<Either<Failure, String>> addFavoritePlace(String client_id, String place_id) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.addFavoritePlace(client_id, place_id);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.message!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null){
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }



  @override
  Future<Either<Failure, String>> removeFavoriteFestival(String client_id, String festival_id) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.removeFavoriteFestival(client_id, festival_id);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.message!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null){
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, String>> removeFavoritePlace(String client_id, String place_id) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.removeFavoriteFestival(client_id, place_id);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.message!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null){
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, List<Festival>>> getUserFestivals(String id) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getUserFestivals(id);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.toDomain());
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null){
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, List<Place>>> getUserPlaces(String id) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getUserPlaces(id);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.toDomain());
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null){
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, List<Booking>>> getUserBooking(String id) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getUserBooking(id);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.toDomain());
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null) {
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

  @override
  Future<Either<Failure, String>> placeBooking(BookingRequest input) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.placeBooking(input);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.message!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null) {
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }
  
  @override
  Future<Either<Failure, int>> logout() async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.logout();
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.status!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null) {
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }
  
  @override
  Future<Either<Failure, String>> verifyPhone(String id, String phone) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.verifyPhone(id, phone);
        print(response);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.message!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null) {
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }
  
  @override
  Future<Either<Failure, String>> verifyOtp(String id, String otp) async {
    if(await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.verifyOtp(id, otp);
        if(response.status == ResponseCode.SUCCESS) {
          //Return Response as Entity
          return Right(response.message!);
        }
        else {
          return Left(Failure( response.status ?? ResponseCode.DEFAULT, response.message?? ResponseMessage.DEFAULT ));
        }
      } catch (error) {
        print(error.toString());
        if(error is DioError && error.response != null) {
          var dioError = error;
          return Left(Failure(dioError.response!.statusCode!, dioError.response!.data["message"]));
        }
        else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    }
    else {
      return Left(Failure(502, "Please check your internet connection"));
    }
  }

}