
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Constant/styles/themes.dart';
import 'View/Page/Home_layout/shop_layout.dart';
import 'View/Page/Login_Page/Login_Screen.dart';
import 'View/Page/On Boareding_Page/Onboarding_Screen.dart';
import 'View_Model/Bloc/HomePage_Cubit/cubit.dart';
import 'View_Model/Bloc/Register_cubit/cubit/cubit.dart';
import 'View_Model/Bloc/bloc_observe.dart';
import 'View_Model/Bloc/login cubit/cubit/Login_Cubit.dart';
import 'View_Model/Bloc/login cubit/cubit/states.dart';
import 'View_Model/network/end_points.dart';
import 'View_Model/network/local/cache_helper.dart';
import 'View_Model/network/remote/dio_helper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = const shop_layout();
    } else {
      widget = const loginScreen();
    }
  } else {
    widget = onBoarding_Screen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget? startWidget;

  MyApp({
    Key? key,
    required this.startWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Shopcubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData()
            ..getAddresses()
            ..getCartData()
            ..getNotifications(),
        ),
        BlocProvider(
          create: (context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (context) => ShopRegisterCubit(),
        )
      ],
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
