
import 'package:flutter/material.dart';

import '../../../Constant/styles/Colors_Style.dart';
import '../Home_layout/shop_layout.dart';

class Success extends StatelessWidget {
  const Success({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children:
             [
                 const Expanded(child: Image(image: AssetImage( "assets/images/success.png"),fit: BoxFit.cover,)),
              const SizedBox(height: 30,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Text('"Login Success"',style: TextStyle(
                          color: Colors.black,
                          fontSize: 30
                      ),),
                      const Spacer(),
                       SizedBox(
                           height: 50,
                           width: double.infinity,
                           child: ElevatedButton(
                             onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context) => const shop_layout(),));
                             },
                             child: const Text('Go to Home',style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 16
                             ),),
                             style: ButtonStyle(
                               shape:MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))) ,
                               backgroundColor:
                               MaterialStateProperty.all(AppStyle.kPrimaryColor),
                             ),

                           )),
                      const Spacer(),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
