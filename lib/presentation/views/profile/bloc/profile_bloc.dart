// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:travellers/app/app_constants.dart';
import 'package:travellers/app/app_pref.dart';
import 'package:travellers/data/requests/requests.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/domain/usecases/auth/login_usecase.dart';
import 'package:travellers/domain/usecases/profile/password_update_usecase.dart';
import 'package:travellers/domain/usecases/profile/profile_update_usecase.dart';
import 'package:travellers/domain/usecases/profile/verify_otp_usecase.dart';
import 'package:travellers/domain/usecases/profile/verify_phone_usecase.dart';
import 'package:travellers/presentation/views/login/bloc/login_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateProfileUsecase? _updateProfileUseCase;
  final UpdatePasswordUsecase? _updatePasswordUseCase;
  final VerifyPhoneUsecase? _verifyPhoneUsecase;
  final VerifyOtpUsecase? _verifyOtpUsecase;
  final AppPreferences _appPreferences;

  ProfileBloc(
    this._updateProfileUseCase,
    this._updatePasswordUseCase,
    this._verifyPhoneUsecase,
    this._verifyOtpUsecase,
    this._appPreferences,
  ) : super(ProfileInitial()) {
    on<UpdateProfileEvent>((event, emit) {
      _updateProfile(event);
    });
    on<ResetPasswordEvent>((event, emit) {
      _resetPassword(event);
    });
    on<VerifyPhoneEvent>((event, emit) {
      _verifyPhone(event);
    });
    on<VerifyOtpEvent>((event, emit) {
      _verifyOtp(event);
    });
  }

  _updateProfile(UpdateProfileEvent event) async {
    emit(ProfileLoading());
    try {
      (await _updateProfileUseCase!.execute(UpdateProfileUsecaseInput(event.user_id, event.first_name, event.last_name, event.email, event.phone))).fold(
        (failure) {
          emit(ProfileError(failure.message));
        }, 
        (entity) {
          User user = User(int.parse(event.user_id) , event.first_name, event.last_name, event.email, event.phone, event.is_phone_verified);
          _appPreferences.setUser(user);
          emit(ProfileUpdated(user));
        }
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  _resetPassword(ResetPasswordEvent event) async {
    emit(ProfileLoading());
    try {
      (await _updatePasswordUseCase!.execute(UpdatePasswordUsecaseInput(event.email, event.password, event.new_password))).fold(
        (failure) {

          emit(ProfileError(failure.message));

        }, 
        (entity) {
          
          emit(ProfileLoaded());

        }
      );
    } catch (e) {
      
      emit(ProfileError(e.toString()));

    }
  }

  _verifyPhone(VerifyPhoneEvent event) async {
    emit(ProfileLoading());
    try {
      (await _verifyPhoneUsecase!.execute( VerifyPhoneUsecaseInput(event.user_id, event.phone))).fold(
        (failure) {

          emit(ProfileError(failure.message));

        }, 
        (entity) {
          
          emit(PhoneVerified(entity));

        }
      );
    } catch (e) {
      
      emit(ProfileError(e.toString()));

    }
  }

  _verifyOtp(VerifyOtpEvent event) async {
    emit(ProfileLoading());
    try {
      (await _verifyOtpUsecase!.execute(VerifyOtpUsecaseInput(event.user_id, event.otp))).fold(
        (failure) {

          emit(ProfileError(failure.message));

        }, 
        (entity) {
          _appPreferences.verifyUserPhone();
          emit(OtpVerified(entity));

        }
      );
    } catch (e) {
      
      emit(ProfileError(e.toString()));

    }
  }


}
