

import '../../../../Model/Login_model/Login_model.dart';

///abstract class
abstract class ShopLoginStates {}
/////////////////////////////////////////////////////////////////////////////////
/// Start
class ShopLoginInitialState extends ShopLoginStates {}
////////////////////////////////////////////////////////////////////////////////
/// Login
class ShopLoginLoadingState extends ShopLoginStates {}
class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState(this.error);
}
///////////////////////////////////////////////////////////////////////////////
class ShopLoginChangePasswordVisibilityState extends ShopLoginStates {}
class verfiyEmailSuccessState  extends ShopLoginStates {}

class verfiyEmailErrorState extends ShopLoginStates {}