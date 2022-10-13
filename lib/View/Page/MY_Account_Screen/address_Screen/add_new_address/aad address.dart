import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Constant/styles/Colors_Style.dart';
import '../../../../../Constant/styles/icon_broken.dart';
import '../../../../../View_Model/Bloc/HomePage_Cubit/cubit.dart';
import '../../../../../View_Model/Bloc/HomePage_Cubit/states.dart';


class AddAddressScreen extends StatelessWidget {
  TextEditingController nameControl = TextEditingController();
  TextEditingController cityControl = TextEditingController();
  TextEditingController regionControl = TextEditingController();
  TextEditingController detailsControl = TextEditingController();
  TextEditingController notesControl = TextEditingController();

  var addressFormKey = GlobalKey<FormState>();

  final bool isEdit;
  final int? addressId;
  final String? name;
  final String? city;
  final String? region;
  final String? details;
  final String? notes;

  AddAddressScreen({Key? key,
    required this.isEdit,
    this.addressId,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: Colors.white.withOpacity(0.4),
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'SOUQ',
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'CANCEL',
                  style: TextStyle(
                      color: AppStyle.kPrimaryColor, ),
                ),
              ),
            ],
          ),
          body: Form(
            key: addressFormKey,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0,left: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is ShopLoadingAddressState)
                      Column(
                        children: const [
                          LinearProgressIndicator(color: AppStyle.kPrimaryColor,),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    const Text(
                      'LOCATION INFORMATION',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 25,),
                    Expanded(
                      child: TextFormField(

                          controller: nameControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,

                            labelText: 'Name',
                            hintText: 'Enter your name',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                               ),
                            errorStyle: TextStyle(fontStyle: FontStyle.italic),
                            prefixIcon: Icon(IconBroken.Profile),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) return 'Name can\'t be empty';
                            return null;
                          }),
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: cityControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,

                            labelText:  'City',
                            hintText: ' Enter your City name',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            errorStyle: TextStyle(fontStyle: FontStyle.italic),
                            prefixIcon: Icon(IconBroken.Location),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'City can\'t be empty';
                            }
                            return null;
                          }),
                    ), 
                    Expanded(
                      child: TextFormField(
                          controller: regionControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,

                            labelText:   'Region',
                            hintText: ' Enter your region',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                               ),
                            errorStyle: TextStyle(fontStyle: FontStyle.italic),
                            prefixIcon: Icon(Icons.merge_type),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Region can\'t be empty';
                            }
                          }),
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: detailsControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,

                            hintText: ' Enter some details',
                            labelText:  'Details',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                               ),
                            errorStyle: TextStyle(fontStyle: FontStyle.italic),
                            prefixIcon: Icon(IconBroken.More_Circle),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Details can\'t be empty';
                            }
                          }),
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: notesControl,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,

                            labelText:  'Notes',
                            hintText: ' Add some notes to help find you',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                ),
                            errorStyle: TextStyle(fontStyle: FontStyle.italic),
                            prefixIcon: Icon(IconBroken.Paper),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Notes can\'t be empty';
                            }
                            return null;
                          }),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, right: 10, left: 10),
                      child: SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if(addressFormKey.currentState!.validate())
                              {
                                Shopcubit.get(context).addAddress(
                                  name: nameControl.text,
                                  city: cityControl.text,
                                  region: regionControl.text,
                                  details: detailsControl.text,
                                  notes: notesControl.text,
                                );
                              }
                            },
                            child: const Text(
                              'Save Address',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                              backgroundColor:
                              MaterialStateProperty.all(AppStyle.kPrimaryColor),
                            ),
                          )),
                    ),

                  ]),
            ),
          ),
        );
      },
    );
  }
}
