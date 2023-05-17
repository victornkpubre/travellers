
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travellers/presentation/base/toast.dart';
import 'package:travellers/presentation/resources/assets_manager.dart';
import 'package:travellers/presentation/resources/color_manager.dart';
import 'package:travellers/presentation/resources/routes_manager.dart';
import 'package:travellers/presentation/resources/string_manager.dart';
import 'package:travellers/presentation/resources/styles_manager.dart';
import 'package:travellers/presentation/resources/values_manager.dart';
import 'package:travellers/presentation/views/register/bloc/register_bloc.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          print("Listener: "+state.toString());
          if(state is RegisterLoaded) {
            //Navigate to Home Screen
            Navigator.pushReplacementNamed(context, Routes.homeRoute);
          }
          if (state is RegisterError) {
            //Display Toastbar
            showErrorToastbar(state.message);
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState> (
          builder: (context, state) {
            print("Builder: "+state.toString());
            
            if(state is RegisterLoading) {
              return const Center(
                child: SizedBox (
                  child: CircularProgressIndicator(),
                )
              );
            }
            else{
              return _buildRegisterScreen();
            }

          },
        ),
      ),
    );

  }

  Widget _buildRegisterScreen(){
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    

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

              //First Name Input Field
              _buildInputField(firstNameController, TextInputType.name, "First Name"),
              SizedBox(height: AppSize.s28),
    
              //Last Name Input Field
              _buildInputField(lastNameController, TextInputType.name, "Last Name"),
              SizedBox(height: AppSize.s28),
    
              //Email Input Field
              _buildInputField(emailController, TextInputType.name, "Email"),
              SizedBox(height: AppSize.s28),
    
              //Password Input Field
              _buildInputField(passwordController, TextInputType.name, "Password"),
              SizedBox(height: AppSize.s28),

              //Phone Input Field
              _buildInputField(phoneController, TextInputType.name, "Phone"),
              SizedBox(height: AppSize.s28),
    
              //Register Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p8),
                child: ElevatedButton(
                  
                  onPressed:() {
                    _register(
                      firstNameController.text.trim(), 
                      lastNameController.text.trim(), 
                      emailController.text.trim(), 
                      passwordController.text.trim(),
                      phoneController.text.trim(), 
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    AppStrings.register,
                    style: StylesManager.getSecondaryInputStyle(),
                  ),
                ),
              ),

              //Google Button
              Column(
                children: [
                  Text (
                    AppStrings.socialLoginText,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p60),
                    child: ElevatedButton(
                      onPressed:() {
                        _googleLogin();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      child: Text (
                        AppStrings.google,
                        style: StylesManager.getSecondaryInputStyle(),
                      ),
                    ),
                  ),
                ],
              ),
    
              //Forgot Password Label
              Padding(
                padding: const EdgeInsets.only(
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
                        Navigator.pushReplacementNamed(context, Routes.loginRoute);
                      }, 
                      child: Text(
                        AppStrings.login,
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

  Widget _buildInputField(TextEditingController controller, TextInputType type, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: TextFormField(
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          labelText: label,
          hintStyle: StylesManager.getDefaultInputStyle(),
          labelStyle: StylesManager.getDefaultInputStyle(),
          enabledBorder: StylesManager.getDefaultInputBorder(),
          focusedBorder: StylesManager.getDefaultInputBorder() 
        ),
      ),
    );
  }



  _register(String first_name, String last_name, String email, String password, String phone) {
    context.read<RegisterBloc>().add(SubmitRegisterEvent(first_name, last_name, email, password, phone));
  }

  _googleLogin(){
    context.read<RegisterBloc>().add(GoogleLoginEvent());
  }

}