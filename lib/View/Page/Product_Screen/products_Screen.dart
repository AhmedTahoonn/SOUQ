import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Constant/styles/Colors_Style.dart';
import '../../../Constant/styles/icon_broken.dart';
import '../../../Model/Cateogries_Model/Get_CategoriesModel.dart';
import '../../../Model/Home_model/home_model.dart';
import '../../../View_Model/Bloc/HomePage_Cubit/cubit.dart';
import '../../../View_Model/Bloc/HomePage_Cubit/states.dart';
import '../Notifications/Notications.dart';
import '../Search_Page/search_Screen.dart';
import 'showProductDetails/Show_Product_details.dart';
import '../Categorires_Screen/categoryProductsScreen.dart';

class products_Screen extends StatelessWidget {
  const products_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model.status!) {
            Fluttertoast.showToast(
                msg: state.model.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFF5F6F9),
            body: ConditionalBuilderRec(
              condition: Shopcubit.get(context).homeModel != null &&
                  Shopcubit.get(context).categoriesModel != null,
              fallback: (context) => const Center(
                child: CircularProgressIndicator(
                  color: AppStyle.kPrimaryColor,
                ),
              ),
              builder: (context) => productsBuilder(
                  Shopcubit.get(context).homeModel!,
                  Shopcubit.get(context).categoriesModel!,
                  context),
            ),
          ),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => search_Screen(),
                          ));
                    },
                    onFieldSubmitted: (value) {},
                    controller: TextEditingController(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const Notifications_Screen(),
                                  ));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: AppStyle.kPrimaryColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black87.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Icon(IconBroken.Notification,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        prefixIcon: const Icon(
                          IconBroken.Search,
                          color: Colors.grey,
                          size: 25,
                        ),
                        border: InputBorder.none,
                        hintText: 'Search...',
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 20)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0,left: 10),
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(

                    'Welcome To SOUQ ❤👋',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: CarouselSlider(
                  items: model.data!.banners
                      .map((e) => Opacity(
                          opacity: .8,
                          child: Container(
                            height: 200,
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black87.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                                image: DecorationImage(
                                    image: NetworkImage('${e.image}'),
                                    fit: BoxFit.cover)),
                          )))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    height: 200,
                    initialPage: 0,
                    reverse: false,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1,
                    autoPlayInterval: const Duration(
                      seconds: 5,
                    ),
                    autoPlayAnimationDuration: const Duration(
                      seconds: 38,
                    ),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categories',
                      style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      itemBuilder: (context, index) => categoriesAvatar(
                          categoriesModel.data!.data[index], context),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel.data!.data.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('New Products',
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0, left: 5),
              child: SizedBox(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 0.0,
                  childAspectRatio: 1 / 1.8,
                  children: List.generate(
                    model.data!.products.length,
                    (index) => productItemBuilder(
                        model.data!.products[index], context),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 180,
                ),
                if (model.discount != 0)
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'EGP',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${model.price.round()}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Shopcubit.get(context).changeFavourites(model.id!);

                            if (kDebugMode) {
                              print(model.id);
                            }
                          },
                          icon: CircleAvatar(
                            radius: 13,
                            backgroundColor:
                                Shopcubit.get(context).favourites[model.id!]!
                                    ? Colors.blue
                                    : Colors.grey,
                            child: const Icon(
                              IconBroken.Heart,
                              color: Colors.white,
                              size: 13,
                            ),
                          ),
                          iconSize: 12,
                        ),
                      ],
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget productItemBuilder(ProductModel model, context) {
    return InkWell(
      onTap: () {
        Shopcubit.get(context).getProductDataDetails(model.id);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const showProductDetails(),
            ));
      },
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Stack(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  Image(
                    image: NetworkImage('${model.image}'),
                    height: 180,
                    width: double.infinity,
                  ),
                ],
              ),
              if (model.discount != 0)
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Discount',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      )),
                )
            ]),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                '${model.name}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('EGP',
                                  style: Theme.of(context).textTheme.caption),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${model.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(fontSize: 15),
                              ),
                            ],
                          ),
                          if (model.discount != 0)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('EGP',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                        )),
                                Text(
                                  '${model.oldPrice}',
                                  style: const TextStyle(
                                      fontSize: 11,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${model.discount}' + '%OFF',
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 9),
                                )
                              ],
                            ),
                        ]),
                  ),
                  IconButton(
                    onPressed: () {
                      Shopcubit.get(context).changeFavourites(model.id!);

                      if (kDebugMode) {
                        print(model.id);
                      }
                    },
                    icon: CircleAvatar(
                      radius: 13,
                      backgroundColor:
                          Shopcubit.get(context).favourites[model.id!]!
                              ? Colors.red
                              : Colors.grey,
                      child: const Icon(
                        IconBroken.Heart,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                    iconSize: 12,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoriesAvatar(DataModel model, context) {
    return InkWell(
      onTap: () {
        Shopcubit.get(context).getCategoriesDetailData(model.id);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryProductsScreen(model.name),
            ));
      },
      child: Column(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                backgroundColor: AppStyle.kPrimaryColor,
                radius: 36,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35,
                child: Image(
                  image: NetworkImage('${model.image}'),
                  width: 50,
                  height: 50,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${model.name}',
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
