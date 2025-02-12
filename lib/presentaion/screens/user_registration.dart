import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/constants/colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/data/user_model.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_bloc.dart';
import 'package:flutter_maps/logic/bloc/phone_auth_state.dart';
import 'package:flutter_maps/presentaion/widget/loading_dialog.dart';
import 'package:flutter_maps/presentaion/widget/text_input_feild.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class UserRegistrationScreen extends StatelessWidget {
  var etNameController = TextEditingController();
  var etEmailController = TextEditingController();
  var etPhoneController = TextEditingController();
  var etPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  UserRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuthAppCubit
        .get(context)
        .userModel = UserModel(name: '', uId: '', phone: '', email: '', image: "" , bio: "");

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            autovalidate: true,
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, userLoginScreen);
                      },
                      icon: Icon(
                        FontAwesomeIcons.arrowAltCircleLeft,
                        size: 30,
                        color: CustomColors.colorGrey,
                      ),
                    ),
                  ),
                  BlocBuilder<FirebaseAuthAppCubit, FirebaseAuthAppState>(
                      builder: (context, state) {
                    var profileImage =
                        FirebaseAuthAppCubit.get(context).profileImage;
                    return Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Container(
                            child: profileImage == null
                                ?  Image.asset("assets/images/user.png" , width: 110, height: 110
                              ,)
                                : CircleAvatar(
                                    radius: 55.0,
                                    backgroundImage: FileImage(profileImage)),
                          ),
                          IconButton(
                            onPressed: () {
                              FirebaseAuthAppCubit.get(context)
                                  .getProfileImage(context);
                            },
                            icon: CircleAvatar(
                                backgroundColor: AppColor.backgroundColor,
                                radius: 30,
                                child: const Icon(
                                  FontAwesomeIcons.arrowAltCircleUp,
                                  size: 20,
                                )),
                          ),
                        ]);
                  }),
                  const SizedBox(height: 20),
                  Text(
                    "Create an account, for free😊",
                    style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1.0,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600,
                        color: CustomColors.colorYellow),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  textInputFormField(
                      textEditingController: etNameController,
                      label: "enter your name",
                      prefix: const Icon(FontAwesomeIcons.userAlt),
                      textSize: 20.0,
                      isTextBio: false,
                      isTextPassword:false,
                      textInputType: TextInputType.name,
                      autoFocus: false),
                  const SizedBox(
                    height: 20,
                  ),
                  textInputFormField(
                      textEditingController: etEmailController,
                      label: "enter your email",
                      prefix: const Icon(Icons.email),
                      textSize: 20.0,
                      isTextBio: false,
                      isTextPassword:false,
                      textInputType: TextInputType.emailAddress,
                      autoFocus: false),
                  const SizedBox(
                    height: 20,
                  ),
                  textInputFormField(
                      textEditingController: etPhoneController,
                      label: "enter your phone",
                      prefix: const Icon(FontAwesomeIcons.phoneAlt),
                      textSize: 20.0,
                      isTextBio: false,
                      isTextPassword:false,
                      textInputType: TextInputType.phone,
                      autoFocus: false),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<FirebaseAuthAppCubit , FirebaseAuthAppState>(
                      builder: (context , state){
                        return textInputFormField(
                            textEditingController: etPasswordController,
                            label: "enter your password",
                            prefix: const Icon(Icons.lock_rounded),
                            textSize: 20.0,
                            isTextBio: false,
                            isTextPassword:  FirebaseAuthAppCubit.get(context).isPasswordShowing,
                            textInputType: TextInputType.visiblePassword,
                            suffix:FirebaseAuthAppCubit.get(context).suffix ,
                            suffixPressed:(){
                              FirebaseAuthAppCubit.get(context).changePasswordVisibility();
                            },
                            autoFocus: false);
                      }

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: CustomColors.colorOrange,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(0, 2),
                              )
                            ]),
                        child: TextButton(
                            onPressed: () {
                              showLoadingDialog(context);
                              userSignUpCreateAccount(context);
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Roboto",
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            )),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account ?",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: CustomColors.colorYellow),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, userLoginScreen);
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColors.colorAmber),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      createUserStates(),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget createUserStates() {
    return BlocListener<FirebaseAuthAppCubit, FirebaseAuthAppState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is UserSignUpLoading) {
          showLoadingDialog(context);
        }
        if (state is UserSignUpSuccess) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(userLoginScreen);
        }
        if (state is UserSignUpError) {
          Navigator.pop(context);
          String errorMeg = state.errorMessage;
          showFlushBar(context, errorMeg , "Error");
        }
        if(state is UploadUserProfileImageSuccess){
          showFlushBar(context, "Your Profile Photo Uploaded Successfully." , "Info");
        }
      },
      child: Container(),
    );
  }

  void userSignUpCreateAccount(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      formKey.currentState!.save();
      FirebaseAuthAppCubit.get(context).userRegister(
          name: etNameController.text,
          phone: etPhoneController.text,
          email: etEmailController.text , password: etPasswordController.text , bio: "hello, there I'm a mobile application developer");
    }
  }

}
