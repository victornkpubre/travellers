import 'package:shared_preferences/shared_preferences.dart';
import 'package:travellers/domain/entities/booking.dart';
import 'package:travellers/domain/entities/user.dart';

const String PREF_KEY_ONBOARDING_STATUS = "PREF_KEY_ONBOARDING_STATUS";
const String PREF_KEY_LOGIN_STATUS = "PREF_KEY_LOGIN_STATUS";
const String PREF_KEY_USER = "PREF_KEY_USER";
const String PREF_KEY_USER_TOKEN = "PREF_KEY_USER_TOKEN";
const String PREF_KEY_BOOKING = "PREF_KEY_BOOKING";

class AppPreferences {
  SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<void> setOnboardingStatus(bool status) async {
    _sharedPreferences.setBool(PREF_KEY_ONBOARDING_STATUS, status);
  }

  Future<bool> getOnboardingStatus() async {
    return _sharedPreferences.getBool(PREF_KEY_ONBOARDING_STATUS) ?? false;
  }

  Future<void> setLoginStatus(bool status) async {
    _sharedPreferences.setBool(PREF_KEY_LOGIN_STATUS, status);
  }

  Future<bool> getLoginStatus() async {
    return _sharedPreferences.getBool(PREF_KEY_LOGIN_STATUS) ?? false;
  }

  Future<void> setUser(User? user) async {
    user == null?
    _sharedPreferences.remove(PREF_KEY_USER):
    _sharedPreferences.setString(PREF_KEY_USER, user.toJson());
  }

  Future<User?> getUser() async {
    String? userJson = _sharedPreferences.getString(PREF_KEY_USER);
    return userJson!=null? User.fromJson(userJson): null;
  }

  Future<void> setUserToken(String? token) async {
    token == null?
    _sharedPreferences.remove(PREF_KEY_USER_TOKEN):
    _sharedPreferences.setString(PREF_KEY_USER_TOKEN, token);
  }

  Future<String?> getUserToken() async {
    return _sharedPreferences.getString(PREF_KEY_USER_TOKEN);
  }

  Future<void> verifyUserPhone() async {
    User ? user = await getUser();
    if(user != null) {
      user.is_phone_verified = 1;  
      setUser(user);
    }
  }

  Future<void> setBooking(Booking? booking) async {
    booking == null?
    _sharedPreferences.remove(PREF_KEY_BOOKING):
    _sharedPreferences.setString(PREF_KEY_BOOKING, booking.toJson());
  }

  Future<Booking?> getBooking() async {
    String? bookingJson = _sharedPreferences.getString(PREF_KEY_BOOKING);
    print(bookingJson);
    return bookingJson!=null? Booking.fromJson(bookingJson): null;
  }



  

}