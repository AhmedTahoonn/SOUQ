import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:dioo/styles/Colors_Style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/HomePage_Cubit/cubit.dart';
import '../../Bloc/Search_Cubit/search cuibt.dart';
import '../../Bloc/Search_Cubit/searchstates.dart';
import '../../models/Search_model/Search_model.dart';
import '../../styles/icon_broken.dart';

class search_Screen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var sreachController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F6F9),
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                    color: Colors.black,
                  )),
              backgroundColor: const Color(0xFFF5F6F9),
              elevation: 0.0,
              automaticallyImplyLeading: false,
              title: const Text(
                'Search',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic),
              ),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter item name';
                        } else {
                          return null;
                        }
                      },
                      controller: sreachController,
                      onFieldSubmitted: (value) {
                        SearchCubit.get(context).search(value);
                      },
                      onChanged: (value) {
                        SearchCubit.get(context).search(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'Enter Item Name..',
                        labelText: 'Search...',
                        labelStyle: const TextStyle(
                          color: AppStyle.kTextColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: const BorderSide(
                              color: AppStyle.kTextColor,
                            ),
                            gapPadding: 5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide:
                                const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide:
                                const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide:
                                const BorderSide(color: AppStyle.kTextColor),
                            gapPadding: 5),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ConditionalBuilderRec(
                      condition: SearchCubit.get(context).model != null,
                      builder: (context) => Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildSearchItem(
                              SearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data![index],
                              context,
                              isOldPrice: false),
                          itemCount: SearchCubit.get(context)
                              .model!
                              .data!
                              .data!
                              .length,
                        ),
                      ),
                      fallback: (context) => Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/research.png'),
                              height: 150,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'This item is not found...!',
                              style: TextStyle(fontSize: 17),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (state is SearchLoadingState)
                              const Center(
                                  child: CircularProgressIndicator(
                                color: AppStyle.kPrimaryColor,
                              )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(
    Product model,
    context, {
    bool isOldPrice = true,
  }) =>
      Column(
        children: [
          Card(
            child: Row(
              children: [
                Container(
                  height: 150,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage(model.image!),
                        width: 120,
                        height: 120,
                      ),
                      if (model.discount != 0 && isOldPrice)
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
                const SizedBox(
                  width: 20,
                ),
                Expanded(
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'EGP',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${model.price}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black,
                                fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (model.discount != 0 && isOldPrice)
                            Text(
                              model.oldPrice.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Shopcubit.get(context)
                                  .changeFavourites(model.id!);
                            },
                            icon: CircleAvatar(
                              radius: 13,
                              backgroundColor:
                                  Shopcubit.get(context).favourites[model.id]!
                                      ? Colors.red
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
