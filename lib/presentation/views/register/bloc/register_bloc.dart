// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:travellers/app/app_constants.dart';
import 'package:travellers/app/app_pref.dart';
import 'package:travellers/domain/usecases/auth/google_login_usecase.dart';
import 'package:travellers/domain/usecases/auth/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterUseCase? _registerUseCase;
  GoogleLoginUseCase? _googleLoginUsecase;
  AppPreferences _appPreferences;
  Auth0 auth0;

  RegisterBloc(
    this._registerUseCase,
    this._googleLoginUsecase,
    this._appPreferences,
    this.auth0,
  ) : super(RegisterInitial()) {
    on<SubmitRegisterEvent>((event, emit) {
      _onRegister(event);
    });
    on<GoogleLoginEvent>((event, emit) {
      _onGoogleLogin(event);
    });
  }

  _onRegister(SubmitRegisterEvent event) async {
    emit(RegisterLoading());
    try {
      (await _registerUseCase!.execute(RegisterUseCaseInput(event.first_name, event.last_name, event.email, event.password, event.phone))).fold(
        (failure) {
          print(failure.code);
          emit(RegisterError(failure.message));
        }, 
        (entity) {
          //Set loginStatus to true
          _appPreferences.setLoginStatus(true);

          //Store user
          _appPreferences.setUser(entity.user!);

          //Store token
          AppConstants.token = entity.token!;
          _appPreferences.setUserToken(entity.token!);
          emit(RegisterLoaded());
        }
      );
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  _onGoogleLogin(GoogleLoginEvent event) async {
    emit(RegisterLoading());
    GoogleLoginUseCaseInput? input = await loginAction(); 
    if(input != null) {
      try {
        (await _googleLoginUsecase!.execute(input)).fold(
          (failure) {
            print(failure.code);
            emit(RegisterError(failure.message));
          }, 
          (entity) {
            //Set loginStatus to true
            _appPreferences.setLoginStatus(true);

            //Store user
            _appPreferences.setUser(entity.user!);

            //Store token
            AppConstants.token = entity.token!;
            _appPreferences.setUserToken(entity.token!);
            emit(RegisterLoaded());
          }
        );
      } catch (e) {
        emit(RegisterError(e.toString()));
      }
    }
  }

  Future<GoogleLoginUseCaseInput?> loginAction() async {
    try {
      final Credentials credentials = await auth0.webAuthentication(scheme: AppConstants.appScheme).login(
        parameters: {
          'connection': "google-oauth2" //or 'connection': "apple" 
        }
      );
      return GoogleLoginUseCaseInput(
        credentials.user.givenName??credentials.user.email!,
        credentials.user.familyName??"",
        credentials.user.email!,
        credentials.user.sub
      );
    } on Exception catch (e, s) {
      emit(RegisterError(e.toString()));
      return null;
    }
  }
}
