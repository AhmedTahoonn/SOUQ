import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/HomePage_Cubit/cubit.dart';
import '../../Bloc/HomePage_Cubit/states.dart';
import '../../styles/icon_broken.dart';
import '../Login_Page/Login_Screen.dart';
import '../../styles/Colors_Style.dart';

import '../../shared/networks/local/cache_helper.dart';
import '../Favourite_Screen/favourite_Screen.dart';
import 'address_Screen/address screen.dart';
import 'profile_screen/profile_Screen.dart';


class MyAccount extends StatelessWidget {

  bool mode=false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit,ShopStates>(
      builder: (context, state) {
        Shopcubit cubit=Shopcubit.get(context);
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6F9),

          appBar: AppBar(
            backgroundColor: const Color(0xFFF5F6F9),
            title: const Text('My Account'),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(

            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Container(
                  color: const Color(0xFFF5F6F9),

                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(cubit.userModel!.data!.image!),
                          radius: 65,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Text(cubit.userModel!.data!.name!,
                        style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w800,),),
                    ],
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: const Text('MY ACCOUNT',style: TextStyle(color: Colors.grey,fontSize: 15,),)),
                Padding(
                  padding: const EdgeInsets.only(right:8.0,left: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35))
                    ),

                    child: Column(
                      children:
                      [
                        ListTile(
                          title: const Text('Profile',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,),),
                          leading:const Icon(IconBroken.Profile,color:Colors.orange),
                          trailing:  const Icon(IconBroken.Arrow___Right_2),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => settings_Screen(),));

                          },
                        ),
                        ListTile(
                          title: const Text('Favourites',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,),),
                          leading:const Icon(IconBroken.Heart,color:Colors.red),
                          trailing:  const Icon(IconBroken.Arrow___Right_2),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const favourite_Screen(),));
                          },
                        ),
                        ListTile(
                          title: const Text('Address',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,),),
                          leading:const Icon(IconBroken.Location,color:Colors.green),
                          trailing:  const Icon(IconBroken.Arrow___Right_2),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddressesScreen(),));
                          },
                        ),



                      ],
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: const Text('SETTINGS',style: TextStyle(color: Colors.grey,fontSize: 15,),)),
                Padding(
                  padding: const EdgeInsets.only(right:8.0,left: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35))
                    ),

                    child: Column(
                      children:
                      [
                        ListTile(
                          title: const Text('Dark Mode',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,),),
                          leading:const Icon(Icons.dark_mode_outlined,color: Colors.black),
                          trailing: Switch(
                            onChanged: (value){

                            },
                            value: mode,
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.white,


                          ),
                          onTap: (){

                          },
                        ),
                        ListTile(
                          title: const Text('Country',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,),),
                          leading:const Icon(Icons.account_balance_outlined,color:Colors.blueGrey),
                          trailing:  const Icon(IconBroken.Arrow___Right_2),
                          onTap: (){},
                        ),
                        ListTile(
                          title: const Text('Language',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,),),
                          leading:const Icon(Icons.map_rounded,color: Colors.brown),
                          trailing:  const Icon(IconBroken.Arrow___Right_2),
                          onTap: (){},
                        ),




                      ],
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: const Text('REACH OUT TO US',style: TextStyle(color: Colors.grey,fontSize: 15,),)),
                Padding(
                  padding: const EdgeInsets.only(right:8.0,left: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35))
                    ),

                    child: Column(
                      children:
                      [
                        ListTile(
                          title: const Text('FAQs Mode',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,),),
                          leading:const Icon(IconBroken.Info_Circle,color:Colors.red),
                          trailing:  const Icon(IconBroken.Arrow___Right_2),
                          onTap: (){},
                        ),
                        ListTile(
                          title: const Text('Contact Us',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,),),
                          leading:const Icon(IconBroken.Calling,color: Colors.green),
                          trailing:  const Icon(IconBroken.Arrow___Right_2),
                          onTap: (){},
                        ),



                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15,),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  height: 60,
                  child: InkWell(
                    onTap: (){
                      CacheHelper.removerData(key:'token').then((value) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const loginScreen(),), (route) => true);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      const [
                        Icon(IconBroken.Logout,color: Colors.red,),
                        SizedBox(width: 10,),
                        Text('SignOut',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,),)
                      ],
                    ),
                  ),
                ),






              ],
            ),
          ),
        );
      },
      listener: (context,state){},
    );

  }
  Widget Size()=>const SizedBox(
    width: 10,
  );
}
