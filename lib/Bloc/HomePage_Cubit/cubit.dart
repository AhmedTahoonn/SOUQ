
import 'dart:convert';
import 'dart:io';

import 'package:dioo/Bloc/HomePage_Cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/Address_model/Add_AddressModel.dart';
import '../../models/Cart_model/Add_CartModel.dart';
import '../../models/Address_model/Get_AddressModel.dart';
import '../../models/Cart_model/Get_CartModel.dart';
import '../../models/Cateogries_Model/Get_CategoriesModel.dart';
import '../../models/Cateogries_Model/Get_CategoriesDetailsModel.dart';
import '../../models/Notications_model/Notifications_model.dart';
import '../../models/Product_model/product_Details.dart';
import '../../models/Address_model/update&Delete_AddressModel.dart';
import '../../models/Cart_model/Update_CartModel.dart';
import '../../modules/Categorires_Screen/cateogries_Screen.dart';
import '../../modules/MY_Account_Screen/MyAccount.dart';
import '../../modules/Product_Screen/products_Screen.dart';
import '../../modules/Cart_Screen/cartScreen.dart';
import '../../models/Favourite_model/changefavorites model.dart';
import '../../models/Favourite_model/Get_FavouriteModel.dart';
import '../../models/Home_model/home_model.dart';
import '../../models/Login_model/Login_model.dart';
import '../../shared/networks/end_points.dart';
import '../../shared/networks/remote/dio_helper.dart';


class Shopcubit extends Cubit<ShopStates>
{
  Shopcubit() : super(Shopintial());
  static Shopcubit get(context)=>BlocProvider.of(context);
  var currentIndex=0;
  List<Widget>screens=[
    const products_Screen(),
     const cateogries_Screen(),
    const CartScreen(),
    MyAccount(),
  ];
  //////////////////////////////////////////////////////////////////////////////
  /// Change BottomNavigationBar
void ShopChangeBottomNavigationbar(index)
{
  currentIndex=index;
  emit(ShopChangeBottomNavigationBarState());
}

  Map<int,bool>favourites={};
  Map <dynamic ,dynamic> cart = {};

  /////////////////////////////////////////////////////////////////////////////
  /// Get Product Data
  HomeModel ?homeModel;
  void getHomeData(){
    emit(ShopProductLoadingHomeState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      if (kDebugMode) {
        print(homeModel!.data!.banners[0].image!);
      }
      if (kDebugMode) {
        print(homeModel!.status);
      }


      homeModel!.data!.products.forEach((element)
      {
        favourites.addAll({
          element.id!:element.inFavourites!,

        });

      });
      homeModel!.data!.products.forEach((element)
      {
        cart.addAll({
          element.id : element.inCart
        });
      });


      if (kDebugMode) {
        print(favourites.toString());
      }
      emit(ShopSuccessProductState());
    }).catchError((error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorProductState(error.toString()));
    });
  }
  /////////////////////////////////////////////////////////////////////////////
  /// Get Product Details
  ProductDetailsModel? productDetailsModel;
  void getProductDataDetails( productId ) {
    productDetailsModel = null;
    emit(productDetailsLoadingState());
    DioHelper.getData(
        url: 'products/$productId',
        token: token
    ).then((value){
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      if (kDebugMode) {
        print('Product Detail '+productDetailsModel!.status.toString());
      }
      emit(productDetailsSuccessState());
    }).catchError((error){
      emit(pproductDetailsErrorState(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Get Categories
  CategoriesModel ?categoriesModel;
  void getCategories(){
    emit(ShopProductLoadingHomeState());

    DioHelper.getData(
      url: GET_GATEGORIES,
      token: token,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
         if (kDebugMode) {
           print(value.data);
         }
      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Get Categories Details
  CategoryDetailModel? categoriesDetailModel;
  void getCategoriesDetailData( int? categoryID ) {
    emit(CategoryDetailsLoadingState());
    DioHelper.getData(
        url: CATEGORIES_DETAIL,
        query: {
          'category_id':'$categoryID',
        }
    ).then((value){
      categoriesDetailModel = CategoryDetailModel.fromJson(value.data);
      if (kDebugMode) {
        print('categories Detail '+categoriesDetailModel!.status.toString());
      }
      emit(CategoryDetailsSuccessState());
    }).catchError((error){
      emit(CategoryDetailsErrorState(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Add To Favourites And Remove
  ChangeFavouritesModel ?changeFavouritesModel;
  void changeFavourites(int productId)
  {
    favourites[productId]=!favourites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(url: FAVORITES,data:
    {
      'product_id':productId,
    },
      token: token,

    ).then((value) {
      changeFavouritesModel=ChangeFavouritesModel.fromjson(value.data);
      if (kDebugMode) {
        print(value.data);
      }
      if(!changeFavouritesModel!.status!)
        {
          favourites[productId]=!favourites[productId]!;
          getFavorites();

        }else{
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavouritesModel!));
    }).catchError((error){
   emit(ShopErrorChangeFavoritesState(error));
    });
  }
  //////////////////////////////////////////////////////////////////////////
  /// Get Favourites
  FavoritesModel ?favoritesModel;
  void getFavorites(){
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data
      );
      if (kDebugMode) {
        print(value.data);
      }
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }
  ///////////////////////////////////////////////////////////////////////////
  /// Get Profile Data
  ShopLoginModel ?userModel;
  void getUserData(){
    emit(ShopLoadingGetUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      if (kDebugMode) {
        print('get profile'+userModel!.data!.name!);
      }
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }
  /////////////////////////////////////////////////////////////////////////////
/// Update Profile Data
  ShopLoginModel ?updateUserModel;
  void updateUserData(
  {
  required String name,
    required String email,
    required String phone,
    required String ?image,
  }
      ){
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name':name,
        'phone':phone,
        'email':email,
        'image':image ?? userModel!.data!.image,
      }
    ).then((value)
    {
      updateUserModel = ShopLoginModel.fromJson(value.data);
      if (kDebugMode) {
        print('update success'+ updateUserModel!.data!.name!);
      }
      emit(ShopSuccessUpdateUserDataState());
      getUserData();
    }).catchError((error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorUpdateUserDataState(error.toString()));
    });
  }
  ShopLoginModel ?password;
////////////////////////////////////////////////////////////////////////////////
  ///  Change Password
  void changePassword({
  required String newPassword,
    required String currentPassword,

  })
  {
    emit(ShopLoadingUpdatePasswordState());
    DioHelper.postData(url: CHANGE_PASSWORD,
        token: token,
        data: {
      'current_password':currentPassword,
      'new_password': newPassword,
    }).then((value) {
      password=ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdatePasswordState());
      getUserData();

      if (kDebugMode) {
        print('changePassword'+password!.status.toString());
      }
    }).catchError((error){
      printFullText(error.toString());
      emit(ShopErrorUpdatePasswordState(error.toString()));
    });
  }
  /////////////////////////////////////////////////////////////////////////////
  /// Add Address
  AddAddressModel? addAddressModel;
  void addAddress({
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }){
    emit(ShopLoadingAddressState());
    DioHelper.postData(
        url: ADDDRESSES,
        token: token,
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          'notes': notes,
          'latitude': latitude,
          'longitude': longitude,
        }
    ).then((value){
      addAddressModel = AddAddressModel.fromJson(value.data);
      emit(ShopSuccessAddressState());
      getAddresses();
      if (kDebugMode) {
        print('Add Address '+ addAddressModel!.status.toString());
      }
    }).catchError((error){
      emit(ShopErrorAddressState(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  ///////////////////////////////////////////////////////////////////////////////
  /// Get Address
   late GetAddressModel getAddressModel;
  void getAddresses() {
    emit(ShopLoadingGetAddressState());
    DioHelper.getData(
      url: ADDDRESSES,
      token: token,
    ).then((value){
      getAddressModel = GetAddressModel.fromJson(value.data);
      if (kDebugMode) {
        print('Get Addresses '+ getAddressModel.status.toString());
      }
      emit(ShopSuccessGetAddressState());
    }).catchError((error){
      emit(ShopErrorGetAddressState(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  /////////////////////////////////////////////////////////////////////////////
  /// Update Address
  UpdateAddressModel ? updateAddressModel;
  void updateAddress({
    required int ?addressId,
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }){
    emit(ShopLoadingUpdateAddressState());
    DioHelper.putData(
        url: 'addresses/$addressId',
        token: token,
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          'notes': notes,
          'latitude': latitude,
          'longitude': longitude,
        }
    ).then((value){
      updateAddressModel = UpdateAddressModel.fromJson(value.data);
      emit(ShopSuccessUpdateAddressState());
      getAddresses();
      if (kDebugMode) {
        print('Update Address '+ updateAddressModel!.status.toString());
      }

    }).catchError((error){
      emit(ShopErrorUpdateAddressState(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  ////////////////////////////////////////////////////////////////////////////
  /// Delete Address
  UpdateAddressModel ? deleteAddressModel;
  void deleteAddress({required addressId}){
    emit(ShopLoadingDeleteAddressState());
    DioHelper.deleteData(
      url: 'addresses/$addressId',
      token: token,
    ).then((value){
      deleteAddressModel = UpdateAddressModel.fromJson(value.data);
      emit(ShopSuccessDeleteAddressState());
      getAddresses();
      if (kDebugMode) {
        print('delete Address '+ deleteAddressModel!.status.toString());
      }

    }).catchError((error){
      emit(ShopErrorDeleteAddressState(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  /// Add To Cart
  late AddCartModel  addCartModel;
  void addToCart(int? productID) {
    emit(AddCartLoadingState());
    DioHelper.postData(
        url: CART,
        token: token,
        data: {
          'product_id': productID
        }
    ).then((value){
      addCartModel = AddCartModel.fromJson(value.data);
      if (kDebugMode) {
        print('AddCart '+ addCartModel.status.toString());
      }
      getCartData();
      emit(AddCartSuccessState());
    }).catchError((error){
      emit(AddCartErrorState(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Update Cart
  late UpdateCartModel  updateCartModel;
  void updateCartData(int? cartId,int? quantity) {
    emit(UpdateCartLoadingState());
    DioHelper.putData(
      url: 'carts/$cartId',
      data: {
        'quantity':'$quantity',
      },
      token: token,
    ).then((value){
      updateCartModel = UpdateCartModel.fromJson(value.data);
      if (kDebugMode) {
        print('Update Cart '+ updateCartModel.status.toString());
      }
      emit(UpdateCartSuccessState());
      getCartData();
    }).catchError((error){
      emit(UpdateCartErrorState(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  //////////////////////////////////////////////////////////////////////////////
  /// Get Cart Data
  late CartModel cartModel;
  void getCartData() {
    emit(GetCartLoadingState());
    DioHelper.getData(
      url: CART,
      token: token,
    ).then((value){
      cartModel = CartModel.fromJson(value.data);
      if (kDebugMode) {
        print('Get Cart '+ cartModel.status.toString());
      }
      emit(GetCartSuccessState());
    }).catchError((error){
      emit(GetCartErrorState(error.toString()));
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  ///////////////////////////////////////////////////////////////////////////////
  /// Pick Profile Image
  var picker = ImagePicker();
  File ?profileImage;
  String ?base64Image;
  Future<void> pickProfileImage() async {
    final response = await picker.pickImage(source: ImageSource.gallery);
    if (response != null) {
      profileImage = File(response.path);
      List<int> imageBytes = profileImage!.readAsBytesSync();
       base64Image = base64Encode(imageBytes);
      print('***************************');
      print(base64Image);
      print('***************************');
      emit(SocialPickedProfilePhotoSuccessState());
    }
    else {
      print(' No image selected');
      emit(SocialPickedProfilePhotoErrorState());
    }
  }
  ///////////////////////////////////////////////////////////////////////////////
  /// Get Notifications
  NotifcationsModles ?NotificationModel;
 void getNotifications()
 {
  DioHelper.getData(url: NOTIVICATIONS,token: token,lang: 'en').then((value) {
    NotificationModel=NotifcationsModles.fromJson(value.data);
    print(NotificationModel!.data!.data);
    print(value.data.toString());
    emit(ShopGetNotificationsSuccessState());
  }).catchError((error){
   print( error.toString());
    emit(ShopGetNotificationsErrorState());

  });
 }
////////////////////////////////////////////////////////////////////////////////

}