
import '../../../../Model/Login_model/Login_model.dart';

/// abstract
abstract class ShopRegisterStates {}
////////////////////////////////////////////////////////////////////////////////
///Start
class ShopRegisterInitialState extends ShopRegisterStates {}
////////////////////////////////////////////////////////////////////////////////
/// Register
class ShopRegisterLoadingState extends ShopRegisterStates {}
class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}
class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);
}
/////////////////////////////////////////////////////////////////////////////////
class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates {}
