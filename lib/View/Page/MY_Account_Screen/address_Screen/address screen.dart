import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Constant/styles/Colors_Style.dart';
import '../../../../Constant/styles/icon_broken.dart';
import '../../../../Model/Address_model/Get_AddressModel.dart';
import '../../../../View_Model/Bloc/HomePage_Cubit/cubit.dart';
import '../../../../View_Model/Bloc/HomePage_Cubit/states.dart';
import 'add_new_address/aad address.dart';
import 'edit_address/update address.dart';



class AddressesScreen extends StatelessWidget {

  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  AddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0.4),
            elevation: 0.0,
            titleSpacing: 0,
            title:const Text('SOUQ',style: TextStyle(
              color: Colors.black,
            ),),
            leading: IconButton(icon: const Icon(IconBroken.Arrow___Left_2),onPressed: (){
              Navigator.pop(context);
            },color: Colors.black,),

          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.only(bottom: 10,right: 20,left: 20),
            child:     SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddAddressScreen(isEdit: false,),));

                  },
                  child: const Text(
                    'Add New Address',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    backgroundColor:
                    MaterialStateProperty.all(AppStyle.kPrimaryColor),
                  ),
                )),

          ),

          body:SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder:(context,index) => Shopcubit.get(context).getAddressModel.data!.data!.isEmpty?
                    Container():
                    addressItem(Shopcubit.get(context).getAddressModel.data!.data![index],context),
                    separatorBuilder:(context,index) => Padding(
                      padding: const EdgeInsets.only(right: 12.0,left: 12),
                      child: Container(
                        height: .5,
                        color: Colors.grey,
                      ),
                    ),
                    itemCount: Shopcubit.get(context).getAddressModel.data!.data!.length
                ),
                Container(color: Colors.white,height: 70,width: double.infinity,)
              ],
            ),
          ),
        );
      },
    );
    // Container(
    //                   width: double.infinity,
    //                   height: 70,
    //                   color: Colors.white,
    //                   padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 15),
    //                   child: MaterialButton(
    //                     onPressed: (){},
    //                     color: Colors.deepOrange,
    //                     //shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    //                     child: Text('Add Address',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 2),),
    //                   ),
    //                 )
  }
  Widget addressItem(AddressData model,context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Icon(IconBroken.Location,color: Colors.green,),
              const SizedBox(width: 5,),
              Text ('${model.city}',style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold,),),
              const Spacer(),
              TextButton(
                  onPressed: (){
                    Shopcubit.get(context).deleteAddress(addressId: model.id);
                  },
                  child: Row(children:
                  const [
                    Icon(IconBroken.Delete,size: 17,color: Colors.red,),
                    SizedBox(width: 3,),
                    Text('Delete',style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black),)
                  ],)
              ),
              Container(height: 20,width: 1,color: Colors.grey[300],),
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateAddressScreen(isEdit: true,addressId: model.id,name: model.name,city: model.city,details: model.details,notes: model.notes,region: model.region),));

                  },
                  child: Row(children:
                  const [
                    Icon(IconBroken.Edit,size: 17,color: Colors.green,),
                    Text('Edit',style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black),)
                  ],)
              ),


            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              SizedBox(
                width : 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Name',style: TextStyle(fontSize: 15,color: Colors.blueGrey,),),
                    SizedBox(height: 10,),
                    Text('Region',style: TextStyle(fontSize: 15,color: Colors.blueGrey,),),
                    SizedBox(height: 10,),
                    Text('Details',style: TextStyle(fontSize: 15,color: Colors.blueGrey,),),
                    SizedBox(height: 10,),
                    Text('Notes',style: TextStyle(fontSize: 15,color: Colors.blueGrey,),),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${model.name}',style: const TextStyle(fontSize: 15,)),
                  const SizedBox(height: 10,),
                  Text('${model.region}',style: const TextStyle(fontSize: 15,)),
                  const SizedBox(height: 10,),
                  Text('${model.details}',style: const TextStyle(fontSize: 15,)),
                  const SizedBox(height: 10,),
                  Text('${model.notes}',style: const TextStyle(fontSize: 15,)),
                  //
                ],)
            ],
          ),
        ),
      ],
    );
  }


}
