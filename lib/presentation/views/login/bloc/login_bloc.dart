// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:travellers/app/app_constants.dart';
import 'package:travellers/app/app_pref.dart';
import 'package:travellers/data/network/dio_factory.dart';
import 'package:travellers/domain/usecases/auth/google_login_usecase.dart';
import 'package:travellers/domain/usecases/auth/login_usecase.dart';

part "login_event.dart";
part "login_state.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase? _loginUseCase;
  GoogleLoginUseCase? _googleLoginUsecase;
  AppPreferences _appPreferences;
  Auth0 auth0;


  LoginBloc(
    this._loginUseCase,
    this._googleLoginUsecase,
    this._appPreferences,
    this.auth0,
  ) : super(LoginInitial()) {
    on<SubmitLoginEvent>((event, emit) {
      _onLogin(event.email, event.password);
    });
    on<GoogleLoginEvent>((event, emit) {
      _onGoogleLogin(event);
    });
  }

  _onLogin(String email, String password) async {
    emit(LoginLoading());
    try {
      (await _loginUseCase!.execute(LoginUseCaseInput(email, password))).fold(
        (failure) {
          print(failure.code);
          emit(LoginError(failure.message));
        }, 
        (entity) {
          //Set loginStatus to true
          _appPreferences.setLoginStatus(true);

          //Store user
          _appPreferences.setUser(entity.user!);

          //Store token
          AppConstants.token = entity.token!;
          _appPreferences.setUserToken(entity.token!);
          emit(LoginLoaded());
        }
      );
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  _onGoogleLogin(GoogleLoginEvent event) async {
    emit(LoginLoading());
    GoogleLoginUseCaseInput? input = await loginAction(); 
    if(input != null) {
      try {
        (await _googleLoginUsecase!.execute(input)).fold(
          (failure) {
            print(failure.code);
            emit(LoginError(failure.message));
          }, 
          (entity) {
            //Set loginStatus to true
            _appPreferences.setLoginStatus(true);

            //Store user
            _appPreferences.setUser(entity.user!);

            //Store token
            AppConstants.token = entity.token!;
            _appPreferences.setUserToken(entity.token!);
            emit(LoginLoaded());
          }
        );
      } catch (e) {
        emit(LoginError(e.toString()));
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
      emit(LoginError(e.toString()));
      return null;
    }
  }


}

