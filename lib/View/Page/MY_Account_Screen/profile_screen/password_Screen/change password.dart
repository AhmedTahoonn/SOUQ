import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../Constant/styles/Colors_Style.dart';
import '../../../../../Constant/styles/icon_broken.dart';
import '../../../../../View_Model/Bloc/HomePage_Cubit/cubit.dart';
import '../../../../../View_Model/Bloc/HomePage_Cubit/states.dart';



class changePassword extends StatefulWidget {
  const changePassword({Key? key}) : super(key: key);

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  TextEditingController currentPass = TextEditingController();

  TextEditingController newPass = TextEditingController();

  var currentEye=false;

  var new_eye=false;

  var changePasskey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit,ShopStates>(
      builder: (context, state) {
       return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title:const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('SOUQ',style: TextStyle(
                color: Colors.black
              ),),
            ),
            actions:
            [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text('CANCEL',style: TextStyle(color: AppStyle.kPrimaryColor),),
              ),
            ],
          ),
          body: Form(
            key:changePasskey,
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0,left: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children :
                  [
                    if(state is ShopLoadingUpdatePasswordState)
                      Column(
                        children: const [
                          LinearProgressIndicator(),
                          SizedBox(height: 20,),
                        ],
                      ),
                    Expanded(
                      child: const Image(
                        image: AssetImage('assets/images/reset-password.png'),
                        height: 120,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: currentPass,
                        obscureText: currentEye,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            prefixIcon:Icon(IconBroken.Lock),
                            labelText: 'Current Password',
                            hintText : 'Enter Current password',
                            hintStyle: const TextStyle(color: Colors.grey,fontSize: 15),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            suffixIcon: IconButton(
                                onPressed: ()
                                {
                                  setState(() {
                                    currentEye=!currentEye;
                                  });
                                },
                              icon: currentEye?const Icon(Icons.remove_red_eye_outlined):const Icon(Icons.visibility_off_outlined),                              )
                        ),
                        validator: (value){
                          if(value!.isEmpty) {
                            return 'This field cant be Empty';
                          }
                          return null;
                        }
                    ),
                    const SizedBox(height: 40,),
                    TextFormField(
                        controller: newPass,
                        obscureText: new_eye,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          prefixIcon:Icon(IconBroken.Lock),
                            labelText: 'New Password',
                            hintText : ' Enter New Password',
                            hintStyle: const TextStyle(color: Colors.grey,fontSize: 15),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            suffixIcon: IconButton(
                                onPressed: (){
                                setState(() {
                                  new_eye=!new_eye;
                                });
                                },
                                icon: new_eye?const Icon(Icons.remove_red_eye_outlined):const Icon(Icons.visibility_off_outlined),
                            )
                        ),
                        validator: (value){
                          if(value!.isEmpty) {
                            return 'This field cant be Empty';
                          }
                          return null;
                        }),
                     Spacer(),
                     Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueGrey,

                        ),
                        child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if(changePasskey.currentState!.validate())
                                {
                                  Shopcubit.get(context).changePassword(newPassword: newPass.text, currentPassword:currentPass.text );
                                }
                              },
                              child: const Text(
                                'Change Password',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                                backgroundColor:
                                MaterialStateProperty.all(AppStyle.kPrimaryColor),
                              ),
                            )),
                      ),
                    ),

                  ]),
            ),
          ),
        );
      },
      listener: (context,state){

      },
    );
  }
}
