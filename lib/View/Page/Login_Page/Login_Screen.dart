import 'package:dioo/shared/networks/end_points.dart';
import 'package:dioo/shared/networks/local/cache_helper.dart';
import 'package:dioo/modules/Login_Page/Login_success.dart';
import 'package:dioo/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Bloc/login cubit/cubit/Login_Cubit.dart';
import '../../Bloc/login cubit/cubit/states.dart';
import '../../Constant/components/components.dart';
import '../../styles/Colors_Style.dart';
import '../Register_Page/RegisterScreen.dart';


class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool remember = false;
  var emailFocused=FocusNode();
  var passwordFocused=FocusNode();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit,ShopLoginStates>(
      builder: (context, state) {
        return  SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Form(
                key: formKey,
                child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign in',
                      style: TextStyle(color: Colors.black,fontSize: 35,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Sign in with your email and password \n or continue with social media',
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
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: emailController,
                      focusNode:emailFocused,
                      onEditingComplete: ()=>Focus.of(context).requestFocus(passwordFocused),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: passwordController,
                      focusNode:passwordFocused,
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
                    Row(
                      children: [
                        Checkbox(
                            value: remember,
                            onChanged: (value) {
                              setState(() {
                                remember = value!;
                              });
                            }),
                        const Text(
                          'Remember me',
                        ),
                        const Spacer(),
                        TextButton(
                          child: const Text(
                            'forgot password',
                            style: TextStyle(color: AppStyle.kTextColor),
                          ),
                          onPressed: () {},
                        ),
                      ],
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
                              ShopLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                            }
                          },
                          child: const Text(
                            'Sign in',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        const Text('Don\'t have an account ?'),
                        TextButton(
                          child: const Text(
                            'Sign up',
                            style: TextStyle(color: AppStyle.kPrimaryColor),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                          },
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is ShopLoginSuccessState) {
          if (state.loginModel.status!) {
            if (kDebugMode) {
              print(state.loginModel.message);
            }
            showToast(
                text: state.loginModel.message.toString(),
                state: ToastStates.SUCCESS);
            if (kDebugMode) {
              print(state.loginModel.data!.token);
            }
            CacheHelper.saveData(
                key: 'token', value: state.loginModel.data!.token)
                .then((value) {
              token = state.loginModel.data!.token!;
             navigateAndFinish(context,  const Success());
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
