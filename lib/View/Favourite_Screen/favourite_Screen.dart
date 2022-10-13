import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/HomePage_Cubit/cubit.dart';
import '../../Bloc/HomePage_Cubit/states.dart';
import '../../models/Favourite_model/Get_FavouriteModel.dart';

import '../../styles/Colors_Style.dart';
import '../../styles/icon_broken.dart';


class favourite_Screen extends StatelessWidget {
  const favourite_Screen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Future refresh()async{

      Shopcubit.get(context).getFavorites();
      Shopcubit.get(context).getHomeData();
      await Future.delayed(const Duration(seconds:2,),);


    }
    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6F9),

          appBar: AppBar(
            backgroundColor: const Color(0xFFF5F6F9),
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: const Text('Favourites',style: TextStyle(
              color: Colors.black
            ),),
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon: const Icon(IconBroken.Arrow___Left_2),color: Colors.black,),
          ),
          body:RefreshIndicator(
            onRefresh: refresh,
            child: ConditionalBuilderRec(
              condition: Shopcubit.get(context).favoritesModel!.data!.data!.isNotEmpty,
              builder: (context)=>ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavoritesItem(Shopcubit.get(context).favoritesModel!.data!.data![index],context),
                separatorBuilder:(context, index) =>Padding(
                  padding: const EdgeInsets.only(right: 15.0,left: 15),
                  child: Container(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                ),
                itemCount: Shopcubit.get(context).favoritesModel!.data!.data!.length,
              ),
              fallback: (context)=>  Center(child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('assets/images/touch.png'),height: 150,width: 150,),
                  SizedBox(height: 8,),
                  Text('Add Some Favourites Product...!',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),)
                ],
              )) ,
            ),
          ),

        );
      },
    );
  }
  Widget favouriteProducts(FavoritesData model,context)
  {
    return InkWell(
      onTap: (){


      },
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Row(
                children:
                [
                  Image(image: NetworkImage('${model.product!.image}'),width: 100,height: 100,),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text('${model.product!.name}',
                          style: const TextStyle(fontSize: 14,),maxLines: 3,overflow: TextOverflow.ellipsis,),
                        const Spacer(),
                        Text('EGP '+'${model.product!.price}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),
                        if(model.product!.discount != 0)
                          Text('EGP'+'${model.product!.oldPrice}',style: const TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey,fontSize: 13),),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            Row(
              children:
              [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: MaterialButton(
                    onPressed: (){

                    },
                    child: const Icon(Icons.remove,size: 18,color: Colors.deepOrange,),
                    minWidth: 20,
                    //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.zero,

                  ),
                ),
                const SizedBox(width: 5,),
                const SizedBox(width: 5,),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: MaterialButton(
                    onPressed: (){
                    },
                    child: Icon(Icons.add,size: 18,color: Colors.green[500],),
                    minWidth: 10,
                    //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.zero,

                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: (){

                  },
                  child: Row(
                    children: const [
                      Icon(IconBroken.Heart,color: Colors.grey,size: 20,),
                      SizedBox(width: 2.5,),
                      Text('Move to Wishlist',style: TextStyle(color: Colors.black,fontSize: 12,),),
                    ],
                  ),
                ),
                const SizedBox(width: 5,),
                Container(height: 20,width: 1,color: Colors.grey[300],),
                TextButton(
                    onPressed: ()
                    {
                      Shopcubit.get(context).addToCart(model.product!.id);
                    },
                    child: Row(
                      children: const [
                        Icon(IconBroken.Delete,color: Colors.red,size: 20,),
                        SizedBox(width: 2.5,),
                        Text('Remove',style: TextStyle(color: Colors.black,fontSize: 12,)),
                      ],
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget buildFavoritesItem(FavoritesData model,context)=> Padding(
    padding: const EdgeInsets.only(left: 10.0,top: 10,bottom: 10),
    child: Column(
      children:
      [
        Row(
          children:
          [
            SizedBox(
              height: 120,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children:
                [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    width: 140,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image:NetworkImage(model.product!.image!),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  if(model.product!.discount!=0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: const Text(
                        'Discount',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    model.product!.name!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children:
                    [
                      const Text('EGP',style: TextStyle(color: Colors.grey,fontSize: 15,),),
                    const SizedBox(width: 5,),
                      Text(
                        model.product!.price.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.blue,
                        ),
                      ),

                      const Spacer(),
                      IconButton(onPressed: (){
                         Shopcubit.get(context).changeFavourites(model.product!.id!);

                      }, icon: CircleAvatar(
                        radius: 13,
                        backgroundColor:  Shopcubit.get(context).favourites[model.product!.id]!?Colors.red:Colors.grey,
                        child: const Icon(IconBroken.Heart,color: Colors.white,size: 13,),),iconSize: 12,),

                    ],
                  ),
                  Row(
                    children: [
                      const Text('EGP',style: TextStyle(color: Colors.grey,fontSize: 15,),),
                      const SizedBox(width: 5,),
                        Text(
                          model.product!.oldPrice.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough
                          ),
                        ),
                      const SizedBox(width: 5,),
                      if(model.product!.discount!=0)

                        Text('${model.product!.discount}'+ ' % OFF',style: const TextStyle(color: Colors.red,fontSize: 11),),

                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
