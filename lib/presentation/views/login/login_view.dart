
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellers/presentation/base/toast.dart';
import 'package:travellers/presentation/resources/assets_manager.dart';
import 'package:travellers/presentation/resources/color_manager.dart';
import 'package:travellers/presentation/resources/routes_manager.dart';
import 'package:travellers/presentation/resources/string_manager.dart';
import 'package:travellers/presentation/resources/styles_manager.dart';
import 'package:travellers/presentation/resources/values_manager.dart';
import 'bloc/login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          print("Listener: "+state.toString());
          if(state is LoginLoaded) {
            //Navigate to Home Screen
            Navigator.pushReplacementNamed(context, Routes.homeRoute);
          }
          if (state is LoginError) {
            //Display Toastbar
            showErrorToastbar(state.message);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState> (
          builder: (context, state) {
            print("Builder: "+state.toString());
            
            if(state is LoginLoading) {
              return const Center(
                child: SizedBox (
                  child: CircularProgressIndicator(),
                )
              );
            }
            else{
              return _buildLoginScreen();
            }

          },
        ),
      ),
    );

  }

  Widget _buildLoginScreen(){
    return  Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: AppPadding.p100),
      color: ColorManager.mainColor,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(ImageAssets.splashLogo),
              SizedBox(height: AppSize.s28,),
    
              //Email Input Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: AppStrings.username,
                    labelText: AppStrings.username,
                    hintStyle: StylesManager.getDefaultInputStyle(),
                    labelStyle: StylesManager.getDefaultInputStyle(),
                    enabledBorder: StylesManager.getDefaultInputBorder(),
                    focusedBorder: StylesManager.getDefaultInputBorder() 
                  ),
                )
              ),
              SizedBox(height: AppSize.s28,),
    
              //Password Input Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: AppStrings.password,
                    labelText: AppStrings.password,
                    hintStyle: StylesManager.getDefaultInputStyle(),
                    labelStyle: StylesManager.getDefaultInputStyle(),
                    enabledBorder: StylesManager.getDefaultInputBorder(),
                    focusedBorder: StylesManager.getDefaultInputBorder() 
                  ),
                ),
              ),
              SizedBox(height: AppSize.s28,),
    
              //Login Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20, vertical: AppPadding.p8),
                child: ElevatedButton(
                  
                  onPressed:() {
                    _login(_emailController.text.trim(), _passwordController.text.trim());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    AppStrings.login,
                    style: StylesManager.getSecondaryInputStyle(),
                  ),
                ),
              ),
              
              Column(
                children: [
                  Text (
                    AppStrings.socialLoginText,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Container(
                    // width: double.infinity,
                    // padding: const EdgeInsets.symmetric(horizontal: AppPadding.p60),
                    child: ElevatedButton(
                      onPressed:() {
                        _googleLogin();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      child: Wrap(
                        children: [
                          Icon(FontAwesomeIcons.google, color: Colors.redAccent, size: 16,),
                          SizedBox(width: 10),
                          Text (
                            AppStrings.google,
                            style: StylesManager.getSecondaryInputStyle(),
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
    
              //Forgot Password Label
              Padding (
                padding: const EdgeInsets.only(
                  top: AppPadding.p8,
                  left: AppPadding.p20,
                  right: AppPadding.p20
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        // _showForgotPasswordDialog();
                      }, 
                      child: Text(
                        AppStrings.forgotPassword,
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, Routes.registerRoute);
                      }, 
                      child: Text(
                        AppStrings.registerText,
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ),
                  ],
                )
              ),
    
            ],
          ),
        ),
      ),
    );
  }

  _login(String email, String password) {
    context.read<LoginBloc>().add(SubmitLoginEvent(email, password));
  }

  _googleLogin(){
    context.read<LoginBloc>().add(GoogleLoginEvent());
  }

}