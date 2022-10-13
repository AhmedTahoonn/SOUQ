import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/HomePage_Cubit/cubit.dart';
import '../../Bloc/HomePage_Cubit/states.dart';
import '../../models/Cart_model/Get_CartModel.dart';
import '../../styles/Colors_Style.dart';

import '../../styles/icon_broken.dart';
import '../Product_Screen/productScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);


  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController counterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit,ShopStates>(
        listener: (context,state){},
        builder:  (context,state) {
          CartModel cartModel = Shopcubit.get(context).cartModel;
         var cartLength = Shopcubit.get(context).cartModel.data!.cartItems.length;
          return Shopcubit.get(context).cartModel.data!.cartItems.length == 0 ?  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.shopping_bag_outlined,size: 70,color: Colors.greenAccent,),
                SizedBox(height: 10,),
                Text('Your Cart is empty',style: TextStyle(fontWeight: FontWeight.bold),),
                Text('Be Sure to fill your cart with something you like',style: TextStyle(fontSize: 15 ))
              ],
            ),
          )
              :Scaffold(
            backgroundColor: const Color(0xFFF5F6F9),

            appBar: AppBar(
              backgroundColor: const Color(0xFFF5F6F9),
                 title: const Text('Cart'),
                 automaticallyImplyLeading: false,
               ),
                body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder:(context,index) => cartProducts(Shopcubit.get(context).cartModel.data!.cartItems[index],context),
                      separatorBuilder:(context,index) =>Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      itemCount: cartLength
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children:
                      [
                        Row(
                          children: [
                            Text('Subtotal'+' ($cartLength Items)',style: const TextStyle(color: Colors.grey)),
                            const Spacer(),
                            Text('EGP '+'${cartModel.data!.subTotal}',style: const TextStyle(color: Colors.grey))
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          children: const [
                            Text('Shipping Fee'),
                            Spacer(),
                            Text('Free',style: TextStyle(color: Colors.green),)
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            const Text('TOTAL',style: TextStyle(fontWeight: FontWeight.bold)),
                            const Text(' Inclusive of VAT',style: TextStyle(fontSize: 10,color: Colors.grey,fontStyle: FontStyle.italic),),
                            const Spacer(),
                            Text('EGP ''${cartModel.data!.total}',style: const TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {

                              },
                              child: const Text(
                                'Check Out',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                                backgroundColor:
                                MaterialStateProperty.all(AppStyle.kPrimaryColor),
                              ),
                            )),


                      ],
                    ),
                  ),

                ],
            ),
          ),
              ) ;
        },
    );
  }

  Widget cartProducts(CartItems? model,context)
  {
    counterController.text = '${model!.quantity}';
    return InkWell(
      onTap: (){
        Shopcubit.get(context).getProductDataDetails(model.product!.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(),));

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
                      int quantity = model.quantity!-1;
                      if(quantity != 0) {
                        Shopcubit.get(context).updateCartData(model.id, quantity);
                      }
                    },
                    child: const Icon(Icons.remove,size: 18,color: Colors.deepOrange,),
                    minWidth: 20,
                    //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.zero,

                  ),
                ),
                const SizedBox(width: 5,),
                Text('${model.quantity}',style: const TextStyle(fontSize: 15),),
                const SizedBox(width: 5,),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: MaterialButton(
                      onPressed: (){
                        int quantity = model.quantity!+1;
                        if(quantity <= 5) {
                          Shopcubit.get(context).updateCartData(model.id, quantity);
                        }
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
}
