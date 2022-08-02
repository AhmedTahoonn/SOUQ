import 'package:dioo/Bloc/Search_Cubit/searchstates.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/Search_model/Search_model.dart';
import '../../shared/networks/end_points.dart';
import '../../shared/networks/remote/dio_helper.dart';




class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel ?model;
  void search(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH,token: token, data: {
      'text':'$text',
    }).then((value) {
      model=SearchModel.fromJson(value.data);
      if (kDebugMode) {
        print(value.data.toString());
      }
      emit(SearchSuccessState());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SearchErrorState());
    });
  }
}