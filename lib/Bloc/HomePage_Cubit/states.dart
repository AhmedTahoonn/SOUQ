
import '../../models/Favourite_model/changefavorites model.dart';
import '../../models/Login_model/Login_model.dart';
/// Abstract
abstract class ShopStates {}
////////////////////////////////////////////////////////////////////////////////
/// Start
class Shopintial extends ShopStates{}
///////////////////////////////////////////////////////////////////////////////
/// BottomNavigation
class ShopChangeBottomNavigationBarState extends ShopStates{}
////////////////////////////////////////////////////////////////////////////////
/// Home
class ShopLoadingHomeState extends ShopStates{}
class ShopSuccessHomeState extends ShopStates{}
class ShopErrorHomeState extends ShopStates{}
//////////////////////////////////////////////////////////////////////////////
///product
class ShopProductLoadingHomeState extends ShopStates{}
class ShopSuccessProductState extends ShopStates{}
class ShopErrorProductState extends ShopStates
{
  final String error;
  ShopErrorProductState(this.error);
}
//////////////////////////////////////////////////////////////////////////////
/// Categories
class ShopCategoriesLoadingHomeState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates {
  final String error;

  ShopErrorCategoriesState(this.error);
}
///////////////////////////////////////////////////////////////////////////////
/// Favourites
class ShopChangeFavoritesLoadingHomeState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates {
final ChangeFavouritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates {
  final String error;
  ShopErrorChangeFavoritesState(this.error);
}
//////////////////////////////////////////////////////////////////////////////
class ShopChangeFavoritesState extends ShopStates {}
///////////////////////////////////////////////////////////////////////////////
/// Get favourites
class ShopSuccessGetFavoritesState extends ShopStates {}
class ShopErrorGetFavoritesState extends ShopStates {
  final String error;

  ShopErrorGetFavoritesState(this.error);
}
class ShopLoadingGetFavoritesState extends ShopStates {}
////////////////////////////////////////////////////////////////////////////////
// Get User Data
class ShopSuccessGetUserDataState extends ShopStates
{
final ShopLoginModel loginModel;
ShopSuccessGetUserDataState(this.loginModel);

}
class ShopErrorGetUserDataState extends ShopStates {
  final String error;

  ShopErrorGetUserDataState(this.error);
}
class ShopLoadingGetUserDataState extends ShopStates {}
/////////////////////////////////////////////////////////////////////////////
/// Update User Data
class ShopErrorUpdateUserDataState extends ShopStates {
  final String error;

  ShopErrorUpdateUserDataState(this.error);
}
class ShopLoadingUpdateUserDataState extends ShopStates {}
class ShopSuccessUpdateUserDataState extends ShopStates {}
////////////////////////////////////////////////////////////////////////////////
//  Change Password
class ShopErrorUpdatePasswordState extends ShopStates {
  final String error;

  ShopErrorUpdatePasswordState(this.error);
}
class ShopLoadingUpdatePasswordState extends ShopStates {}
class ShopSuccessUpdatePasswordState extends ShopStates {}
////////////////////////////////////////////////////////////////////////////////
// Add Address
class ShopErrorAddressState extends ShopStates {
  final String error;
  ShopErrorAddressState(this.error);
}
class ShopLoadingAddressState extends ShopStates {}
class ShopSuccessAddressState extends ShopStates {}
/////////////////////////////////////////////////////////////////////////////////
/// Get Address
class ShopErrorGetAddressState extends ShopStates {
  final String error;
  ShopErrorGetAddressState(this.error);
}
class ShopLoadingGetAddressState extends ShopStates {}
class ShopSuccessGetAddressState extends ShopStates {}
///////////////////////////////////////////////////////////////////////////////
/// Update Address
class ShopErrorUpdateAddressState extends ShopStates {
  final String error;
  ShopErrorUpdateAddressState(this.error);
}
class ShopLoadingUpdateAddressState extends ShopStates {}
class ShopSuccessUpdateAddressState extends ShopStates {}
////////////////////////////////////////////////////////////////////////////////
/// Delete Address
class ShopErrorDeleteAddressState extends ShopStates {
  final String error;

  ShopErrorDeleteAddressState(this.error);
}
class ShopLoadingDeleteAddressState extends ShopStates {}
class ShopSuccessDeleteAddressState extends ShopStates {}
////////////////////////////////////////////////////////////////////////////////
/// Categories Details
class CategoryDetailsErrorState extends ShopStates {
  final String error;

  CategoryDetailsErrorState(this.error);
}
class CategoryDetailsLoadingState extends ShopStates {}
class CategoryDetailsSuccessState extends ShopStates {}
//////////////////////////////////////////////////////////////////////////////
/// Product Details
class pproductDetailsErrorState extends ShopStates {
  final String error;

  pproductDetailsErrorState(this.error);
}
class productDetailsLoadingState extends ShopStates {}
class productDetailsSuccessState extends ShopStates {}
////////////////////////////////////////////////////////////////////////////////////
/// Add Cart
class AddCartErrorState extends ShopStates {
  final String error;

  AddCartErrorState(this.error);
}
class AddCartLoadingState extends ShopStates {}
class AddCartSuccessState extends ShopStates {}
////////////////////////////////////////////////////////////////////////////////
/// Update Cart
class UpdateCartErrorState extends ShopStates {
  final String error;

  UpdateCartErrorState(this.error);
}
class UpdateCartLoadingState extends ShopStates {}
class UpdateCartSuccessState extends ShopStates {}
///////////////////////////////////////////////////////////////////////////////
///Get Cart
class GetCartErrorState extends ShopStates {
  final String error;

  GetCartErrorState(this.error);
}
class GetCartLoadingState extends ShopStates {}
class GetCartSuccessState extends ShopStates {}
///////////////////////////////////////////////////////////////////////////////
/// pick profile image
class SocialPickedProfilePhotoSuccessState extends ShopStates {}
class SocialPickedProfilePhotoErrorState extends ShopStates {}
////////////////////////////////////////////////////////////////////////////////
/// Upload Photo
class ShopLoadingUploadPhotoState extends ShopStates {}
class ShopSuccessUploadPhotoState extends ShopStates {}
class ShopErrorUploadPhotoState extends ShopStates {}
////////////////////////////////////////////////////////////////////////////////
///Get Notifications
class ShopGetNotificationsSuccessState extends ShopStates {}
class ShopGetNotificationsErrorState extends ShopStates {}
///////////////////////////////////////////////////////////////////////////////
