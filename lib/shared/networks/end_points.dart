import 'package:flutter/foundation.dart';

const LOGIN='login';
const HOME='home';
const REGISTER='register';

void printFullText(text)
{
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text.forEach((match){
    if (kDebugMode) {
      print(match.group(0));
    }
  }));
}
String ?token='';
const GET_GATEGORIES='categories';
const FAVORITES='favorites';
const PROFILE='profile';
const UPDATE_PROFILE = 'update-profile';
const SEARCH='products/search';
const CHANGE_PASSWORD='change-password';
const Address='addresses';
const CATEGORIES_DETAIL =  'products';
const CART = 'carts';
const RESET_PASSWORD='reset-password';
const NOTIVICATIONS='notifications';
const ADDDRESSES='addresses';

