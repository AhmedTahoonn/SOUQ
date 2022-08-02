import 'package:dioo/Bloc/Register_cubit/cubit/cubit.dart';
import 'package:dioo/Bloc/login%20cubit/cubit/states.dart';
import 'package:dioo/modules/Login_Page/Login_Screen.dart';
import 'package:dioo/modules/Home_layout/shop_layout.dart';
import 'package:dioo/modules/On%20Boareding_Page/Onboarding_Screen.dart';
import 'package:dioo/shared/networks/end_points.dart';
import 'package:dioo/shared/networks/local/cache_helper.dart';
import 'package:dioo/shared/networks/remote/dio_helper.dart';
import 'package:dioo/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/HomePage_Cubit/cubit.dart';
import 'Bloc/login cubit/cubit/Login_Cubit.dart';
import 'modules/Login_Page/Login_success.dart';
import 'modules/Register_Page/RegisterScreen.dart';
import 'Bloc/bloc_observe.dart';


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
