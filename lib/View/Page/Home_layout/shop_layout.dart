import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Constant/styles/Colors_Style.dart';
import '../../../Constant/styles/icon_broken.dart';
import '../../../View_Model/Bloc/HomePage_Cubit/cubit.dart';
import '../../../View_Model/Bloc/HomePage_Cubit/states.dart';


class shop_layout extends StatelessWidget {
  const shop_layout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          bottomNavigationBar: BottomNavigationBar(

            selectedItemColor: AppStyle.kPrimaryColor,
            currentIndex: Shopcubit.get(context).currentIndex,
            onTap: (index){
              Shopcubit.get(context).ShopChangeBottomNavigationbar(index);
            },
            type: BottomNavigationBarType.fixed,
            items:
            const [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Category),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Bag_2),label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Profile),label: 'MY Account'),




            ],
          ),
          body: Shopcubit.get(context).screens[Shopcubit.get(context).currentIndex],
        );
      },
    );
  }
}
