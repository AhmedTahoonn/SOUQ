import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Constant/styles/Colors_Style.dart';
import '../../../Constant/styles/icon_broken.dart';
import '../../../Model/Cateogries_Model/Get_CategoriesModel.dart';
import '../../../View_Model/Bloc/HomePage_Cubit/cubit.dart';
import '../../../View_Model/Bloc/HomePage_Cubit/states.dart';
import '../Search_Page/search_Screen.dart';
import 'categoryProductsScreen.dart';

class cateogries_Screen extends StatelessWidget {
  const cateogries_Screen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFF5F6F9),

            body: Column(
                children: [
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      child: Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => search_Screen(),));
                          },
                          onFieldSubmitted: (value) {},
                          controller: TextEditingController(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(onPressed: (){},icon: const Icon(Icons.more_vert)),
                              prefixIcon: const Icon(
                                IconBroken.Search,
                                color: Colors.grey,
                                size: 25,
                              ),
                              border: InputBorder.none,
                              hintText: 'Search...',
                              hintStyle: const TextStyle(color: Colors.grey, fontSize: 20)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: ListView.separated(itemBuilder: (context, index) =>buildCatItem(Shopcubit.get(context).categoriesModel!.data!.data[index],context) , separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ), itemCount: Shopcubit.get(context).categoriesModel!.data!.data.length,

                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                ],
              ),
          ),
        );
      },
    );
  }

 Widget buildCatItem(DataModel model,context)=> Padding(
   padding: const EdgeInsets.only(right: 10.0,left: 10),
   child: InkWell(
     onTap: (){
       Shopcubit.get(context).getCategoriesDetailData(model.id);
       Navigator.push(context, MaterialPageRoute(builder: (context) =>  CategoryProductsScreen(model.name),));
     },
     child: Card(

       child: SizedBox(
         height: 100,
         child: Row(
           children:
           [
             Padding(
               padding: const EdgeInsets.only(left: 13.0),
               child: Stack(
                 children: [
                   const CircleAvatar(
                     radius: 31,
                     backgroundColor: AppStyle.kPrimaryColor,
                   ),
                   CircleAvatar(
                     backgroundColor: Colors.white,
                     radius: 30,
                     backgroundImage: NetworkImage(model.image!),

                   ),
                 ],
               ),
             ),
             const SizedBox(
               width: 20,
             ),
             Expanded(
               child: Text(model.name!,

                 style: const TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 16,

                 ),
               ),
             ),
             const Spacer(),
             Padding(
               padding: const EdgeInsets.only(top: 8.0,bottom: 8),
               child: Container(
                 height: 90,
                 width: .5,
                 color: Colors.black,
               ),
             ),
             const Padding(
               padding: EdgeInsets.only(left: 15.0,right: 15),
               child: Icon(IconBroken.Arrow___Right_2),
             ),
           ],
         ),
       ),
     ),
   ),
 );


}
