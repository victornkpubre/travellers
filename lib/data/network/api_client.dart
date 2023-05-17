import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:travellers/app/app_constants.dart';
import 'package:travellers/data/responses/responses.dart';
import 'package:travellers/domain/entities/activity.dart';
import 'package:travellers/domain/entities/festival.dart';
import 'package:travellers/domain/entities/place.dart';

part "api_client.g.dart";

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ApiClient {

  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/api/auth/login")
  Future<AuthResponse> login(
    @Field("email") String email,
    @Field("password") String password,
    @Field("device_name") String device_name
  );

  @POST("/api/auth/logout")
  Future<BaseResponse>logout ();

  @POST("/api/auth/register")
  Future<AuthResponse> register(
    @Field("first_name") String first_name,
    @Field("last_name") String last_name,
    @Field("email") String email,
    @Field("password") String password,
    @Field("phone") String phone
  );

  @POST("/api/auth/reset")
  Future<BaseResponse> updatePassword(
    @Field("email") String email,
    @Field("password") String password,
    @Field("new_password") String new_password
  );

  @POST("/api/auth/google")
  Future<AuthResponse> googleLogin(
    @Field("first_name") String first_name,
    @Field("last_name") String last_name,
    @Field("email") String email,
    @Field("sub") String sub,
  );

  @POST("/api/auth/verify/phone")
  Future<BaseResponse> verifyPhone(
    @Field("id") String user_id,
    @Field("phone") String phone,
  );

  @POST("/api/auth/verify/otp")
  Future<BaseResponse> verifyOtp(
    @Field("id") String user_id,
    @Field("otp") String otp,
  );

  @GET("/api/home/data")
  Future<HomeDataResponse> getHomeData();

  @PUT("/api/clients/{id}")
  Future<BaseResponse> updateProfile(
    @Path("id") String id,
    @Field("first_name") String first_name,
    @Field("last_name") String last_name,
    @Field("email") String email,
    @Field("phone") String phone
  );

  @POST("/api/client/place")
  Future<UserPlaceResponse> getUserPlaces(
    @Field("client_id") String client_id,
  );

  @POST("/api/client/place/add")
  Future<BaseResponse> addUserPlace(
    @Field("client_id") String client_id,
    @Field("place_id") String place_id,
  );

  @POST("/api/client/place/remove")
  Future<BaseResponse> removeUserPlace(
    @Field("client_id") String client_id,
    @Field("place_id") String place_id,
  );

  @POST("/api/client/festival")
  Future<UserFestivalResponse> getUserFestivals(
    @Field("client_id") String client_id,
  );

  @POST("/api/client/festival/add")
  Future<BaseResponse> addUserFestival(
    @Field("client_id") String client_id,
    @Field("festival_id") String festival_id,
  );

  @POST("/api/client/festival/remove")
  Future<BaseResponse> removeUserFestival(
    @Field("client_id") String client_id,
    @Field("festival_id") String festival_id,
  );

  @GET("/api/bookings/client/{id}")
  Future<BookingsResponse> getUserBookings (
    @Path("id") String id,
  );

  @POST("/api/bookings/create")
  Future<BaseResponse> placeBooking (
    @Field("client_id") String client_id,
    @Field("places") List<int>? places,
    @Field("festivals") List<int>? festivals,
    @Field("activities") List<int>? activities
  );

}