

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:travellers/app/app_constants.dart';
import 'package:travellers/domain/usecases/auth/google_login_usecase.dart';
import 'package:travellers/domain/usecases/auth/register_usecase.dart';
import 'package:travellers/domain/usecases/bookings/place_booking_usecase.dart';
import 'package:travellers/domain/usecases/bookings/toggle_festival_in_booking.dart';
import 'package:travellers/domain/usecases/bookings/toggle_place_in_booking.dart';
import 'package:travellers/domain/usecases/bookings/toggle_activity_in_booking.dart';
import 'package:travellers/domain/usecases/bookings/user_bookings_usecase.dart';
import 'package:travellers/domain/usecases/favorites/add_favorite_festival_usecase.dart';
import 'package:travellers/domain/usecases/favorites/add_favorite_place_usecase.dart';
import 'package:travellers/domain/usecases/favorites/favorite_festivals_usecase.dart';
import 'package:travellers/domain/usecases/favorites/favorite_places_usecase.dart';
import 'package:travellers/domain/usecases/favorites/remove_favorite_festival_usecase.dart';
import 'package:travellers/domain/usecases/favorites/remove_favorite_place_usecase.dart';
import 'package:travellers/domain/usecases/home_data_usecase.dart';
import 'package:travellers/domain/usecases/auth/login_usecase.dart';
import 'package:travellers/domain/usecases/auth/logout_usecase.dart';
import 'package:travellers/domain/usecases/profile/password_update_usecase.dart';
import 'package:travellers/domain/usecases/profile/profile_update_usecase.dart';
import 'package:travellers/domain/usecases/profile/verify_otp_usecase.dart';
import 'package:travellers/domain/usecases/profile/verify_phone_usecase.dart';
import 'package:travellers/presentation/views/checkout/bloc/checkout_bloc.dart';
import 'package:travellers/presentation/views/emotions/bloc/emotions_bloc.dart';
import 'package:travellers/presentation/views/favorites/bloc/favorite_bloc.dart';
import 'package:travellers/presentation/views/festivals/bloc/booking_bloc.dart';
import 'package:travellers/presentation/views/festivals/bloc/festivals_bloc.dart';
import 'package:travellers/presentation/views/history/bloc/history_bloc.dart';
import 'package:travellers/presentation/views/home/bloc/booking_bloc.dart';
import 'package:travellers/presentation/views/home/bloc/home_bloc.dart';
import 'package:travellers/presentation/views/login/bloc/login_bloc.dart';
import 'package:travellers/presentation/views/places/bloc/booking_bloc.dart';
import 'package:travellers/presentation/views/places/bloc/places_bloc.dart';
import 'package:travellers/presentation/views/profile/bloc/profile_bloc.dart';
import 'package:travellers/data/data_source/remote_data_source.dart';
import 'package:travellers/data/network/api_client.dart';
import 'package:travellers/data/network/dio_factory.dart';
import 'package:travellers/data/network/network_info.dart';
import 'package:travellers/data/repository/repository.dart';
import 'package:travellers/domain/repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travellers/app/app_pref.dart';
import 'package:travellers/presentation/views/register/bloc/register_bloc.dart';

class DependencyInjector {
  late SharedPreferences _sharedPreferences;
  late Repository _repository;
  late AppPreferences _appPreferences;
  late Auth0 _auth0;
  late Dio dio;

  initPref() async {
    NetworkInfo netwotkInfo = NetworkInfoImplementation(InternetConnectionChecker());
    _sharedPreferences = await SharedPreferences.getInstance();
    _appPreferences = AppPreferences(_sharedPreferences);
    dio = await DioFactory(_appPreferences).getDio();
    ApiClient apiClient = ApiClient(dio);
    RemoteDataSource remoteData = RemoteDataSourceImplementation(apiClient);
    _repository = RepositoryImplementation(netwotkInfo, remoteData);
    _auth0 = Auth0(AppConstants.domain, AppConstants.clientId);
  }

  List<SingleChildWidget> inject(){
    return [
      Provider<Dio>(create: (_) => dio),
      Provider<SharedPreferences>(create: (_) => _sharedPreferences),
      Provider<AppPreferences>(create: (_) => _appPreferences),
      BlocProvider(create: (context) =>  LoginBloc(LoginUseCase(_repository), GoogleLoginUseCase(_repository), _appPreferences, _auth0)),
      BlocProvider(create: (context) =>  RegisterBloc(RegisterUseCase(_repository), GoogleLoginUseCase(_repository), _appPreferences, _auth0)),
      BlocProvider(create: (context) =>  HomeBloc(HomeDataUseCase(_repository), LogoutUseCase(_repository), _appPreferences)),
      BlocProvider(create: (context) =>  ProfileBloc(UpdateProfileUsecase(_repository), UpdatePasswordUsecase(_repository), VerifyPhoneUsecase(_repository), VerifyOtpUsecase(_repository), _appPreferences)),
      BlocProvider(create: (context) =>  FavoriteBloc(FavoriteFestivalsUseCase(_repository), FavoritePlacesUseCase(_repository), _appPreferences)),
      BlocProvider(create: (context) =>  CheckoutBloc(BookingUseCase(_repository), _appPreferences)),
      BlocProvider(create: (context) =>  PlaceBookingBloc(TogglePlaceInBookingUseCase(_repository),_appPreferences)),
      BlocProvider(create: (context) =>  FestivalBookingBloc(ToggleFestivalInBookingUseCase(_repository),_appPreferences)),
      BlocProvider(create: (context) =>  ActivityBookingBloc(ToggleActivityInBookingUseCase(_repository),_appPreferences)),      
      BlocProvider(create: (context) =>  HistoryBloc(GetBookingsUseCase(_repository),_appPreferences)),            
      BlocProvider(create: (context) =>  EmotionsBloc(
        TogglePlaceInBookingUseCase(_repository), 
        ToggleFestivalInBookingUseCase(_repository), 
        ToggleActivityInBookingUseCase(_repository),
        _appPreferences
      )),      
      
      BlocProvider(create: (context) =>  PlacesBloc(
        AddFavoritePlaceUseCase(_repository),
        RemoveFavoritePlaceUseCase(_repository),
        FavoritePlacesUseCase(_repository),
        _appPreferences
      )),
      
      BlocProvider(create: (context) =>  FestivalsBloc(
        AddFavoriteFestivalUseCase(_repository),
        RemoveFavoriteFestivalUseCase(_repository),
        FavoriteFestivalsUseCase(_repository),
        _appPreferences
      )),

      ];
  }
}