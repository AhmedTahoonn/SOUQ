
import 'package:dioo/modules/Login_Page/Login_Screen.dart';
import 'package:dioo/shared/networks/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Constant/components/components.dart';
import '../../styles/Colors_Style.dart';

class BoardingModel {
  final String image;
  final String text;

  BoardingModel({
    required this.text,
    required this.image,
  });
}

class onBoarding_Screen extends StatelessWidget {
  List<BoardingModel> boardingItems = [
    BoardingModel(
        text: "Welcome to SOUQ, Let’s shop!",
        image: "assets/images/splash_1.png"),
    BoardingModel(
        text:
            "We help people connect with store \naround United State of America",
        image: "assets/images/splash_2.png"),
    BoardingModel(
        text: "We show the easy way to shop. \nJust stay at home with us",
        image: "assets/images/splash_3.png"),
  ];
  var boardController = PageController();

  onBoarding_Screen({Key? key}) : super(key: key);
  void submit(context) {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value!) {
        navigateAndFinish(context,  const loginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(boardingItems[index]),
                itemCount: boardingItems.length,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                      const Spacer(),
                    SmoothPageIndicator(
                        controller: boardController,
                        count: boardingItems.length,
                        effect:  const ExpandingDotsEffect(
                            dotColor: Colors.grey,
                            activeDotColor: AppStyle.kPrimaryColor,
                            dotHeight: 10,
                            expansionFactor: 4,
                            dotWidth: 10,
                            spacing: 5)),
                    const Spacer(),
                    SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            submit(context);
                          },
                          child: const Text('Continue',style: TextStyle(
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
    );
  }

  Widget buildOnBoardingItem(BoardingModel model) => Column(
        children: [
          const Spacer(),
          const Text(
            'SOUQ',
            style: TextStyle(
                fontSize: 40,
                color: AppStyle.kPrimaryColor,
                fontWeight: FontWeight.bold),
          ),
          Text(
            model.text,
            textAlign: TextAlign.center,
          ),
          const Spacer(
            flex: 2,
          ),
          Image(
            image: AssetImage(model.image),
            width: 235,
            height: 265,
          ),
        ],
      );
}
