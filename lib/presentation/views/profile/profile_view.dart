import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travellers/domain/entities/user.dart';
import 'package:travellers/presentation/base/toast.dart';
import 'package:travellers/presentation/resources/assets_manager.dart';
import 'package:travellers/presentation/resources/color_manager.dart';
import 'package:travellers/presentation/resources/routes_manager.dart';
import 'package:travellers/presentation/resources/styles_manager.dart';
import 'package:travellers/presentation/resources/values_manager.dart';
import 'package:travellers/presentation/views/login/bloc/login_bloc.dart';
import 'package:travellers/presentation/views/profile/bloc/profile_bloc.dart';

class ProfileView extends StatefulWidget {
  final user;
  ProfileView({super.key, required this.user});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late User user;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = User.fromMap(widget.user);
    _firstNameController.text = user.first_name;
    _lastNameController.text = user.last_name;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            //Display Toastbar
            showErrorToastbar(state.message);
          }
          if (state is PhoneVerified) {
            //Display Toastbar
            showErrorToastbar(state.message);
          }
          if (state is OtpVerified) {
            setState(() {
              user.is_phone_verified = 1;
            });
            //Display Toastbar
            showErrorToastbar(state.message);
          }
          if (state is ProfileLoaded) {
            //Display Toastbar
            showErrorToastbar("Profile Updated Succesfully");
          }
          if (state is ProfileUpdated) {
            setState(() {
              user = state.user;
            });
            //Display Toastbar
            showErrorToastbar("Profile Updated Succesfully");
          }
        },
        builder:(context, state) {
          if(state is ProfileLoading){
            return Container (
              child: Center (
                child: CircularProgressIndicator(),
              ),
            );
          }
          else {
            return _buildProfileView();
          }
          
        },
      ),
    );
  }

  _buildProfileView() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            //Main Panel
            Positioned(
              top: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 1 / 3),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Name Input Field
                            _buildInputField(_firstNameController,
                                TextInputType.name, "First Name"),
                            SizedBox(height: AppSize.s12),
                            _buildInputField(_lastNameController,
                                TextInputType.name, "Last Name"),
                            SizedBox(height: AppSize.s12),
    
                            //Email Input Field
                            _buildInputField(_emailController,
                                TextInputType.emailAddress, "Email"),
                            SizedBox(height: AppSize.s12),
    
                            //Phone Input Field
                            SizedBox(
                              width: AppSizes.getWidth(context),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _buildInputField(_phoneController, TextInputType.phone, "Phone #"),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        if(user.is_phone_verified==0){
                                          _verifyPhoneNumber(_phoneController.text.trim());
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(20),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AppPadding.p8,
                                            vertical: AppPadding.p8),
                                        width: MediaQuery.of(context).size.width / 2,
                                        color: ColorManager.mainColor,
                                        child: Center(
                                            child: AppText(
                                                text: user.is_phone_verified==0?"Verifiy": "Verified",
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                            SizedBox(height: AppSize.s12),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _updatePassword();
                        },
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppPadding.p8,
                                  vertical: AppPadding.p8),
                              width: MediaQuery.of(context).size.width / 2,
                              color: ColorManager.mainColor,
                              child: Center(
                                  child: AppText(
                                      text: "Reset Password ",
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _updateProfile();
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(10),
                          color: ColorManager.mainColor,
                          width: double.infinity,
                          child: Center(
                              child: AppText(
                            text: "Update",
                            color: Colors.white,
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    
            //Banner
            Positioned(
              top: 0,
              left: -25,
              child: Container(
                width: MediaQuery.of(context).size.width + 50,
                height: MediaQuery.of(context).size.height * 1 / 4,
                decoration: BoxDecoration(
                    color: ColorManager.mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          MediaQuery.of(context).size.width / 2),
                      bottomRight: Radius.circular(
                          MediaQuery.of(context).size.width / 2),
                    )),
                child: SizedBox(),
              ),
            ),
    
            //Back Button
            Positioned(
              left: 20,
              top: MediaQuery.of(context).size.height * 1/ 20,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.backspace,size: 30, color: Colors.white,),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.homeRoute);
                    },
                  )
                ],
              ),
            ),
    
            //Profile Icon
            Positioned(
              top: (MediaQuery.of(context).size.height * 1 / 4) - 50,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              MediaQuery.of(context).size.width / 2),
                        )),
                    child: Icon(
                      Icons.person,
                      color: ColorManager.mainColor,
                      size: 50,
                    )),
              ),
            ),
          ],
        )),
    );
  }

  _buildInputField(TextEditingController controller, TextInputType type, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: TextFormField(
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration (
          labelText: label,
          hintStyle: StylesManager.getDefaultInputStyle(),
          labelStyle: StylesManager.getSecondaryInputStyle(),
          enabledBorder: StylesManager.getDefaultInputBorder(),
          focusedBorder: StylesManager.getDefaultInputBorder()
        ),
      )
    );
  }

  _verifyPhoneNumber(String phone){
    _updateProfile();
    _showOtpDialog(phone);
    
  }

  _updateProfile() {
    context.read<ProfileBloc>().add(UpdateProfileEvent(
      user.id.toString(),
      _firstNameController.text.trim(),
      _lastNameController.text.trim(),
      _emailController.text.trim(),
      _phoneController.text.trim(),
      user.is_phone_verified,
    ));
}

  _updatePassword() async {
    final result = await _getResetDetails();

    context.read<ProfileBloc>().add(ResetPasswordEvent(
      user.email,
      result["password"],
      result["new_password"],
    ));
  }

  Future _getResetDetails() async {
    return await showDialog(
      context: context,
      builder: (context) {
        TextEditingController _passwordController = TextEditingController();
        TextEditingController _newPasswordController = TextEditingController();

        return AlertDialog(
          title: AppLargeText(
            text: "Reset Password", color: ColorManager.mainColor
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: ColorManager.buttonBackground,
                  child: _buildInputField(
                      _passwordController, TextInputType.name, "Password"),
                ),
                SizedBox(height: AppSize.s8),
                Container(
                  color: ColorManager.buttonBackground,
                  child: _buildInputField(_newPasswordController,
                      TextInputType.name, "New Password"),
                ),
                SizedBox(height: AppSize.s8),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.mainColor),
            ),
            ElevatedButton(
              onPressed: () {
                if (_passwordController.text.isNotEmpty && _newPasswordController.text.isNotEmpty) {
                  Navigator.pop(context, {
                    "password": _passwordController.text.trim(),
                    "new_password": _newPasswordController.text.trim(),
                  });
                } else {
                  showErrorToastbar("All fields are required");
                }
              },
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.mainColor
              ),
            ),
          ],
        );
      },
    );
  }

  Future _showOtpDialog(String phone) async {
    return await showDialog(
      context: context,
      builder: (context) {
        TextEditingController _codeController = TextEditingController();

        return AlertDialog(
          title: AppLargeText(
            text: "Verifiy Phone #", color: ColorManager.mainColor
          ),
          content: SingleChildScrollView (
            child: Column (
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: ColorManager.buttonBackground,
                  child: _buildInputField(
                      _codeController, TextInputType.name, "Otp"),
                ),
                SizedBox(height: AppSize.s8),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                   onPressed: () {
                      context.read<ProfileBloc>().add(VerifyPhoneEvent(
                        user.id.toString(),
                        phone
                      ));
                    },
                    child: Text('Send Otp'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.mainColor
                    ),
                  ),
                ), 
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.mainColor),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        if(_codeController.text.isNotEmpty){
                          context.read<ProfileBloc>().add(VerifyOtpEvent(
                            user.id.toString(),
                            _codeController.text.trim()
                          ));
                        }
                        Navigator.pop(context);
                      },
                      child: Text('Confirm'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.mainColor
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
