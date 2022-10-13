import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Constant/styles/Colors_Style.dart';
import '../../../View_Model/Bloc/login cubit/cubit/Login_Cubit.dart';
import '../../../View_Model/Bloc/login cubit/cubit/states.dart';


class forgot extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  forgot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit,ShopLoginStates>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Forgot password',
                          style: TextStyle(color: Colors.black,fontSize: 35,fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        const Text(
                          'Please enter your email and we will send \n you a link to return to your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
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
                            suffixIcon: const Icon(Icons.email_outlined),
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
                          height: 40,
                        ),

                        SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if(formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).resetPassword(email: emailController.text, );
                                }
                              },
                              child: const Text(
                                'Send',
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
                          height: 25,
                        ),

                        SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {

                              },
                              child: const Text(
                                'Cancel',
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
                            const Text('Don\'n have an account ?'),
                            TextButton(
                              child: const Text(
                                'Sign up',
                                style: TextStyle(color: AppStyle.kPrimaryColor),
                              ),
                              onPressed: () {},
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (context,state)
      {

      },
    );
  }
}
