import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:dioo/modules/MY_Account_Screen/profile_screen/password_Screen/change%20password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/HomePage_Cubit/cubit.dart';
import '../../../Bloc/HomePage_Cubit/states.dart';
import '../../../styles/Colors_Style.dart';
import '../../../styles/icon_broken.dart';


class settings_Screen extends StatelessWidget {
 var nameController=TextEditingController();
 var emailController=TextEditingController();
 var phoneController=TextEditingController();

  settings_Screen({Key? key}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessGetUserDataState)
          {

          }
      },
      builder: (context,state){
        var model=Shopcubit.get(context).userModel;
        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;
        Shopcubit cubit=Shopcubit.get(context);


        return ConditionalBuilderRec(
          condition:Shopcubit.get(context).userModel!=null ,
          builder:(context)=>Scaffold(
            backgroundColor: const Color(0xFFF5F6F9),

            appBar:  AppBar(
              backgroundColor: Colors.white,

              automaticallyImplyLeading: false,
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              },icon: const Icon(IconBroken.Arrow___Left_2,color: Colors.black,)),
              elevation: 0.0,
              title: const Text('My Profile',style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.black,

              ),

              ),

            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0,left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10,),
                            Align(
                              alignment: Alignment.center,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [

                                  CircleAvatar(
                                    backgroundImage: NetworkImage(cubit.userModel!.data!.image!),
                                    radius: 75,
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppStyle.kPrimaryColor,
                                    child: IconButton(onPressed: (){
                                      Shopcubit.get(context).pickProfileImage();
                                    }, icon: const Icon(IconBroken.Camera),color: Colors.white,),
                                  )
                                ],
                              ),
                            ),
                            if(Shopcubit.get(context).profileImage!=null)
                            MaterialButton(onPressed: (){
                              Shopcubit.get(context).updateUserData(name: nameController.text, email: emailController.text, phone: phoneController.text,image: Shopcubit.get(context).base64Image);
                            },child: const Text('upload profile',style: TextStyle(
                                color:Colors.white
                            ),),color:AppStyle.kPrimaryColor,)

                          ],
                        ),
                      ),
                      if(state is ShopLoadingUpdateUserDataState)
                      const LinearProgressIndicator(
                        color: Colors.lightBlue,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35))
                        ),

                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0,left:10),
                              child: Row(
                                children: [
                                  const Text('PERSONAL INFORMATION',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  const Spacer(),
                                  TextButton(onPressed: (){
                                    Shopcubit.get(context).updateUserData(name: nameController.text, email: emailController.text, phone: phoneController.text,image: Shopcubit.get(context).base64Image);

                                  }, child: const Text('Update',style: TextStyle(
                                    color: AppStyle.kPrimaryColor
                                  ),))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    gapPadding: 10
                                  ),
                                labelText: 'Name',
                                hintText: 'Enter Your Name',
                                prefixIcon: const Icon(IconBroken.Profile),
                              ),

                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText:'Enter Your Email' ,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    gapPadding: 10
                                ),

                                prefixIcon: const Icon(IconBroken.Message),
                              ),

                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    gapPadding: 10
                                ),
                                hintText: 'Enter Your Phone',
                                labelText: 'Phone',
                                prefixIcon: const Icon(IconBroken.Call),
                              ),

                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),


                      Container(
                        color: Colors.white,
                        width: double.infinity,

                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('SECURITY INFORMATION',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            const SizedBox(height: 5,),
                            OutlinedButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const changePassword(),));
                                },
                                child: const Text('Change Password',style: TextStyle(
                                    color: AppStyle.kPrimaryColor

                                ),)
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ) ,
          fallback: (context)=>const Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
}
