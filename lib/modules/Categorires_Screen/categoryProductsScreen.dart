import 'package:dioo/styles/Colors_Style.dart';
import 'package:flutter/material.dart' show AlignmentDirectional, AppBar, BouncingScrollPhysics, BuildContext, Card, Center, CircularProgressIndicator, Color, Colors, Column, Container, CrossAxisAlignment, EdgeInsets, EdgeInsetsDirectional, FontWeight, GridView, Icon, IconButton, Image, InkWell, NetworkImage, NeverScrollableScrollPhysics, Padding, Row, Scaffold, SingleChildScrollView, SizedBox, Spacer, Stack, StatelessWidget, Text, TextDecoration, TextOverflow, TextStyle, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/HomePage_Cubit/cubit.dart';
import '../../Bloc/HomePage_Cubit/states.dart';
import '../../models/Cateogries_Model/Get_CategoriesDetailsModel.dart';

import '../../styles/icon_broken.dart';


class CategoryProductsScreen extends StatelessWidget {
  final String? categoryName;
    CategoryProductsScreen(this.categoryName);
  @override
  Widget build(BuildContext context) {


     return BlocConsumer<Shopcubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){

          return Scaffold(
            backgroundColor: const Color(0xFFF5F6F9),
            appBar: AppBar(
              backgroundColor: const Color(0xFFF5F6F9),
              elevation: 0.0,
              titleSpacing: 0,
              title:const Text('SOUQ',style: TextStyle(
                color: Colors.black
              ),),

              actions: [
                IconButton(
                    onPressed: () {
                    },
                    icon: const Icon(IconBroken.Search)),


              ],
            ),
            body: state is CategoryDetailsLoadingState ?
            const Center(child: CircularProgressIndicator(color: AppStyle.kPrimaryColor,),) :  Shopcubit.get(context).categoriesDetailModel!.data.productData.isEmpty ?
            const Center(child: Text('Coming Soon',style: TextStyle(fontSize: 50),),) :
            SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0,left: 5),
                    child: Column(
                      children: [
                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            child: Text('$categoryName',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                        ),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                            Shopcubit.get(context).categoriesDetailModel!.data.productData.length,
                                (index) => Shopcubit.get(context).categoriesDetailModel!.data.productData.isEmpty ?
                                   const Center(child: Text('Coming Soon',style: TextStyle(fontSize: 50),),) :
                                   productItemBuilder(Shopcubit.get(context).categoriesDetailModel!.data.productData[index],context)
                                ),

                        childAspectRatio: 0.6,
                      ),
                    ],
                ),
                  ),
              ),
            ),
          );
        },
      );
  }

  Widget productItemBuilder (ProductData model,context) {
    return InkWell(
      onTap: (){

        },
      child: Card(

        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0,left: 8,bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Stack(
                  alignment:AlignmentDirectional.bottomStart,
                  children:[
                    Image(image: NetworkImage('${model.image}'),height: 150,width: 150,),
                    if(model.discount != 0 )
                      Container(
                          color: Colors.red,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text('Discount',style: TextStyle(fontSize: 14,color: Colors.white),),
                          )
                      )
                  ]),
              Text('${model.name}',maxLines: 3, overflow: TextOverflow.ellipsis,),
              const Spacer(),
              Row(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('EGP',style: TextStyle(color: Colors.grey[800],fontSize: 12,),),
                            Text('${model.price}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),),
                          ],
                        ),
                        if(model.discount != 0 )
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('EGP',style: TextStyle(color: Colors.grey,fontSize: 10,decoration: TextDecoration.lineThrough,),),
                              Text('${model.oldPrice}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey),
                              ),
                              SizedBox(width:5),
                              Text('${model.discount}'+'% OFF',style: const TextStyle(color: Colors.red,fontSize: 11),)
                            ],
                          ),
                      ]
                  ),
                  const Spacer(),
                  // IconButton(
                  //   onPressed: ()
                  //   {
                  //     Shopcubit.get(context).changeToFavorite(model.id);
                  //     print(model.id);
                  //   },
                  //   icon: Conditional.single(
                  //     context: context,
                  //     conditionBuilder:(context) => Shopcubit.get(context).favorites[model.id],
                  //     widgetBuilder:(context) => Shopcubit.get(context).favoriteIcon,
                  //     fallbackBuilder: (context) => Shopcubit.get(context).unFavoriteIcon,
                  //   ),
                  //   padding: EdgeInsets.all(0),
                  //   iconSize: 20,
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
