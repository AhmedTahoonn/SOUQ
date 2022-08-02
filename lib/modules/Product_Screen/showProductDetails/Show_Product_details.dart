import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:dioo/modules/MY_Account_Screen/MyAccount.dart';
import 'package:dioo/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Bloc/HomePage_Cubit/cubit.dart';
import '../../../Bloc/HomePage_Cubit/states.dart';
import '../../../models/Product_model/product_Details.dart';
import '../../../styles/Colors_Style.dart';

class showProductDetails extends StatefulWidget {
  const showProductDetails({Key? key}) : super(key: key);

  @override
  State<showProductDetails> createState() => _showProductDetailsState();
}

class _showProductDetailsState extends State<showProductDetails> {
  var selectedItem = 0;
  var read = 6;
  var show = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      builder: (context, state) {
        ProductDetailsData? model =
            Shopcubit.get(context).productDetailsModel?.data;
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6F9),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF5F6F9),
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

          ),
          body: ConditionalBuilderRec(
            condition: state is! productDetailsLoadingState,
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    child: Image(
                      image: NetworkImage(model!.images![selectedItem]),
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0, left: 12),
                      child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ListView.builder(

                            itemBuilder: (context, index) =>
                                buildSmallImage(model.images![index], index),
                            itemCount: model.images!.length,
                            scrollDirection: Axis.horizontal,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0,left: 10),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(top: 15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.name!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Price',style: TextStyle(
                              color:AppStyle.kPrimaryColor,
                              fontSize: 15,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline
                            ),

                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('EGP',style: TextStyle(color: Colors.grey[800],fontSize: 12,),),
                                const SizedBox(width: 3,),
                                Text('${model.price}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
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
                                const SizedBox(width:5),
                                Text('${model.discount}'+'% OFF',style: const TextStyle(color: Colors.red,fontSize: 11),)
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Description',style: TextStyle(
                                color:AppStyle.kPrimaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline
                            ),

                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              model.description!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              maxLines: read,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (read == 90) {
                                      read = 6;
                                      show = !show;
                                    } else {
                                      read = 90;
                                      show = !show;
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      show
                                          ? 'See less Details'
                                          : 'See More Details',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppStyle.kPrimaryColor),
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                      color: AppStyle.kPrimaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(top: 15),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (Shopcubit.get(context).cart[model.id]) {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Already in Your Cart \nCheck your cart To Edit or Delete ',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    Shopcubit.get(context).addToCart(model.id);
                                    Fluttertoast.showToast(
                                        msg:
                                        'Added to your cart successfully ',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);

                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(IconBroken.Buy),
                                    SizedBox(width: 5,),
                                    Text(
                                      'Add to Cart',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  backgroundColor: MaterialStateProperty.all(
                                      AppStyle.kPrimaryColor),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator(color: AppStyle.kPrimaryColor,)),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildSmallImage(model, index) => InkWell(
        onTap: () {
          setState(() {
            selectedItem = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.only(right: 10),
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: selectedItem == index
                  ? Border.all(color: AppStyle.kPrimaryColor)
                  : null),
          child: Image(
            image: NetworkImage(model.toString()),
          ),
        ),
      );
}
