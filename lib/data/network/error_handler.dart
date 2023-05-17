
import 'package:dio/dio.dart';
import 'package:travellers/data/network/failure.dart';



class ErrorHandler {

  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if(error is DioError) {
      failure = _handleError(error);
    }
    else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }



  Failure _handleError(DioError error) {
    switch(error.type) {
      case DioErrorType.connectionError:
        return DataSource.CONNECT_ERROR.getFailure();
      case DioErrorType.badCertificate:
        return DataSource.BAD_CERTIFICATION.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.RECIEVE_TIMEOUT.getFailure();
      case DioErrorType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioErrorType.badResponse:
        return DataSource.BAD_RESPONSE.getFailure();
      case DioErrorType.unknown:
        switch (error.response!.statusCode){
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORISED:
            return DataSource.UNAUTHORISED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }
    }
  }




}





enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  UNKNOWN,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  BAD_CERTIFICATION, 
  CONNECT_ERROR, 
  BAD_RESPONSE,
  DEFAULT, 
  
}

class ResponseCode {
  //Api status code
  static const int  SUCCESS = 200;
  static const int  NO_CONTENT = 201;
  static const int  BAD_REQUEST = 400;
  static const int  FORBIDDEN = 403;
  static const int  UNAUTHORISED = 401;
  static const int  NOT_FOUND = 404;
  static const int  INTERNAL_SERVER_ERROR = 500;
  static const int  BAD_CERTIFICATION = 495;
  static const int  CONNECT_ERROR = 502;
  static const int  BAD_RESPONSE = 500;

  //Local status code
  static const int  UNKNOWN = -1;
  static const int  CONNECT_TIMEOUT = -3;
  static const int  CANCEL = -3;
  static const int  RECIEVE_TIMEOUT = -4;
  static const int  SEND_TIMEOUT = -5;
  static const int  CACHE_ERROR = -6;
  static const int  NO_INTERNET_CONNECTION = -7;
  static const int DEFAULT = 200;
}

class ResponseMessage {
  //Api status code
  static const String  SUCCESS = "success";
  static const String  NO_CONTENT = "success with no contenString";
  static const String  BAD_REQUEST = "bad request, try again later";
  static const String  FORBIDDEN = "forbidden request, try again later";
  static const String  UNAUTHORISED = "user is unauthorised, try again later";
  static const String  NOT_FOUND = "Url is not fund, try again later";
  static const String  INTERNAL_SERVER_ERROR = "Some thing, try again later";
  static const String  BAD_CERTIFICATION = "bad certificate";
  static const String  CONNECT_ERROR = "connction error";
  static const String  BAD_RESPONSE = "bad response";

  //Local status code
  static const String  UNKNOWN = "some thing went wrong, try again later";
  static const String  CONNECT_TIMEOUT = "time out error, try again later";
  static const String  CANCEL = "request was cancelled, try again later";
  static const String  RECIEVE_TIMEOUT = "time out error, try again later";
  static const String  SEND_TIMEOUT = "time out error, try again later";
  static const String  CACHE_ERROR = "cache error, try again later";
  static const String  NO_INTERNET_CONNECTION = "please check your internet connection";
  static const String  DEFAULT = "Logic Error from Api side";
}


extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR, ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.BAD_CERTIFICATION:
        return Failure(ResponseCode.BAD_CERTIFICATION, ResponseMessage.BAD_CERTIFICATION);
      case DataSource.CONNECT_ERROR:
        return Failure(ResponseCode.CONNECT_ERROR, ResponseMessage.CONNECT_ERROR);
      case DataSource.BAD_RESPONSE:
        return Failure(ResponseCode.BAD_RESPONSE, ResponseMessage.BAD_RESPONSE);
  
      default:
        return Failure(ResponseCode.UNKNOWN, ResponseMessage.UNKNOWN);
    }
  }
}
