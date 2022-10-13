import 'package:dioo/Bloc/Register_cubit/cubit/cubit.dart';

import 'package:dioo/shared/networks/end_points.dart';
import 'package:dioo/shared/networks/local/cache_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../Bloc/Register_cubit/cubit/states.dart';
import '../../Constant/components/components.dart';
import '../../styles/Colors_Style.dart';
import '../../styles/icon_broken.dart';

class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
               resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.black,fontSize: 35,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    const Text(
                      'Register Account',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    const Text(
                      "Complete your details or continue \n with social media",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      controller: usernameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(IconBroken.Profile),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Enter Your Username',
                        labelText: 'username',
                        labelStyle: const TextStyle(
                          color: AppStyle.kTextColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                              color: AppStyle.kTextColor,
                            ),
                            gapPadding: 5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(IconBroken.Message),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Enter Your Email',
                        labelText: 'email',
                        labelStyle: const TextStyle(
                          color: AppStyle.kTextColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                              color: AppStyle.kTextColor,
                            ),
                            gapPadding: 5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone';
                        }
                        return null;
                      },
                      controller: phoneController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(IconBroken.Call),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Enter Your Phone',
                        labelText: 'phone',
                        labelStyle: const TextStyle(
                          color: AppStyle.kTextColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                              color: AppStyle.kTextColor,
                            ),
                            gapPadding: 5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(IconBroken.Lock),

                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Enter Your Password',
                        labelText: 'password',
                        labelStyle: const TextStyle(
                          color: AppStyle.kTextColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                              color: AppStyle.kTextColor,
                            ),
                            gapPadding: 5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if(formKey.currentState!.validate())
                            {
                              ShopRegisterCubit.get(context).userRegister(email:emailController.text, password: passwordController.text, phone: phoneController.text, name: usernameController.text);
                            }
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                            backgroundColor:
                            MaterialStateProperty.all(AppStyle.kPrimaryColor),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 20,
                            child: SvgPicture.asset('assets/icons/google-icon.svg')),
                        const SizedBox(width: 10,),
                        CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 20,
                            child: SvgPicture.asset('assets/icons/twitter.svg')),
                        const SizedBox(width: 10,),

                        CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 20,
                            child: SvgPicture.asset('assets/icons/facebook-2.svg')),

                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'By continuing your confirm that you agree \n with our Term and Condition',
                      textAlign: TextAlign.center,
                      style:Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener:  (context, state) {
        if (state is ShopRegisterSuccessState) {
          if (state.loginModel.status!) {
            showToast(
              text: state.loginModel.message,
              state: ToastStates.SUCCESS,
            );
            if (kDebugMode) {
              print(state.loginModel.message);
            }
            if (kDebugMode) {
              print(state.loginModel.data!.token);
            }
            CacheHelper.saveData(
                key: 'token', value: state.loginModel.data!.token)
                .then((value) {
              token = state.loginModel.data!.token!;
              //navigateAndFinish(context, const ShopLayoutScreen());
            });
          } else {
            if (kDebugMode) {
              print(state.loginModel.message);
            }
            showToast(
              text: state.loginModel.message,
              state: ToastStates.ERROR,
            );
          }
        }

      },
    );
  }
}
