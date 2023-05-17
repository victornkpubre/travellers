import 'package:travellers/app/app_constants.dart';
import 'package:travellers/data/network/api_client.dart';
import 'package:travellers/data/requests/requests.dart';
import 'package:travellers/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> login(LoginRequest loginRequest);
  Future<BaseResponse> logout();
  Future<AuthResponse> register(RegisterRequest registerRquest);
  Future<AuthResponse> googleRegister(GoogleRegisterRequest registerRquest);
  
  Future<BaseResponse> verifyPhone(String id, String phone);
  Future<BaseResponse> verifyOtp(String id, String otp);
  Future<HomeDataResponse> getHomeData();
  Future<BaseResponse> updateProfile(UpdateProfileRequest request);
  Future<BaseResponse> updatePassword(UpdateProfileRequest request);

  Future<UserFestivalResponse> getUserFestivals(String id);
  Future<UserPlaceResponse> getUserPlaces(String id);

  Future<BaseResponse> addFavoritePlace(String client_id, String place_id);
  Future<BaseResponse> removeFavoritePlace(String client_id, String place_id);
  Future<BaseResponse> addFavoriteFestival(String client_id, String festival_id);
  Future<BaseResponse> removeFavoriteFestival(String client_id, String festival_id);
  
  Future<BookingsResponse> getUserBooking(String id);
  Future<BaseResponse> placeBooking(BookingRequest input);
  
}

class RemoteDataSourceImplementation implements RemoteDataSource {
  ApiClient _appServiceClient;
  RemoteDataSourceImplementation(this._appServiceClient);

  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(loginRequest.email, loginRequest.password, loginRequest.device_name);
  }
  
  @override
  Future<HomeDataResponse> getHomeData() async {
    return await _appServiceClient.getHomeData();
  }
  
  @override
  Future<BaseResponse> updatePassword(UpdateProfileRequest request) async {
    return await _appServiceClient.updatePassword(request.email!, request.password!, request.new_password!);
  }
  
  @override
  Future<BaseResponse> updateProfile(UpdateProfileRequest request) async {
    return await _appServiceClient.updateProfile(request.user_id!, request.first_name!, request.last_name!, request.email!, request.phone!);
  }
  
  @override
  Future<BaseResponse> addFavoriteFestival(String client_id, String festival_id) async {
    return await _appServiceClient.addUserFestival(client_id, festival_id);
  }
  
  @override
  Future<BaseResponse> addFavoritePlace(String client_id, String place_id) async {
    return await _appServiceClient.addUserPlace(client_id, place_id);
  }
  
  @override
  Future<UserFestivalResponse> getUserFestivals(String id) async {
    return await _appServiceClient.getUserFestivals(id);
  }
  
  @override
  Future<UserPlaceResponse> getUserPlaces(String id) async {
    return await _appServiceClient.getUserPlaces(id);
  }

  @override
  Future<BookingsResponse> getUserBooking(String id) async {
    return await _appServiceClient.getUserBookings(id);
  }
  
  @override
  Future<BaseResponse> placeBooking(BookingRequest input) async {
    return await _appServiceClient.placeBooking(input.client_id, input.places, input.festivals, input.activities);
  }
  
  @override
  Future<BaseResponse> removeFavoriteFestival(String client_id, String festival_id) async {
    return await _appServiceClient.removeUserFestival(client_id, festival_id);
  }
  
  @override
  Future<BaseResponse> removeFavoritePlace(String client_id, String place_id) async {
    return await _appServiceClient.removeUserPlace(client_id, place_id);
  }
  
  @override
  Future<AuthResponse> register(RegisterRequest registerRquest) async {
    return await _appServiceClient.register(
      registerRquest.first_name, 
      registerRquest.last_name, 
      registerRquest.email, 
      registerRquest.password, 
      registerRquest.phone
    );
  }
  
  @override
  Future<BaseResponse> logout() async {
    return await _appServiceClient.logout();
  }

  @override
  Future<BaseResponse> verifyPhone(String id, String phone) async {
    var result =  await _appServiceClient.verifyPhone(id, phone);
    return result;
  }

  @override
  Future<BaseResponse> verifyOtp(String id, String otp) async {
    return await _appServiceClient.verifyOtp(id, otp);
  }
  
  @override
  Future<AuthResponse> googleRegister(GoogleRegisterRequest registerRquest) async {
    return await _appServiceClient.googleLogin(
      registerRquest.first_name, 
      registerRquest.last_name, 
      registerRquest.email, 
      registerRquest.sub
    );
  }

  

}