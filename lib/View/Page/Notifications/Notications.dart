
import 'package:dioo/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/HomePage_Cubit/cubit.dart';
import '../../Bloc/HomePage_Cubit/states.dart';
import '../../models/Notications_model/Notifications_model.dart';



class Notifications_Screen extends StatelessWidget {
  const Notifications_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit,ShopStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Notifications',style: TextStyle(
              color: Colors.black,

            ),),
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon: const Icon(IconBroken.Arrow___Left_2)),

          ),
          body: Padding(
            padding: const EdgeInsets.only(right: 8.0,left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Expanded(
                  child: ListView.separated(itemBuilder: (context, index) => buildNotificationItem(Shopcubit.get(context).NotificationModel!.data!.data![index],context),
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) =>Padding(
                      padding: const EdgeInsets.only(right: 15.0,left: 15),
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          Container(
                            height: .7,
                            width: double.infinity,
                            color: Colors.grey,
                          ),
                          const SizedBox(

                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    itemCount: Shopcubit.get(context).NotificationModel!.data!.data!.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
      listener: (context,state)
      {

      },
    );
  }
  Widget buildNotificationItem(DataData model,context)=> Row(

    children:
     [
       const CircleAvatar(
        radius: 40,
        child: Icon(IconBroken.Notification,color: Colors.green,),
        backgroundColor:  Color(0xFFF5F6F9),


      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Text(model.title!,maxLines: 2, overflow: TextOverflow.ellipsis,style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),),
            const SizedBox(
              height: 5,
            ),
            Text(model.message!, overflow: TextOverflow.ellipsis,maxLines: 3,style:Theme.of(context).textTheme.caption!.copyWith(
              fontSize: 12,
              fontStyle: FontStyle.italic
            )),
          ],
        ),
      ),
    ],
  );
}
