import 'package:flutter/material.dart';
import 'package:pagination/core/api/dio_helper.dart';
import 'package:pagination/core/api/end_point.dart';
import 'package:pagination/cubit/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Passengers> passengers = [];
  int currentPage = 0;
  final int size = 30;
  bool isFirstLoadRunning = false;

  void getData() {
    debugPrint('fromFirst');
    emit(AppGetDataLoadingState());
    isFirstLoadRunning = true;
    DioHelper.getData(url: EndPoints.passenger, query: {
      'page': currentPage,
      'size': size,
    }).then((value) {
      value.data['data'].forEach((element) {
        passengers.add(Passengers.fromJson(element));
      });
      isFirstLoadRunning = false;
      emit(AppGetDataSuccessState());
    }).catchError((error) {
      print('error ====> ${error.toString()}');
      emit(AppGetDataErrorState());
    });
  }

  bool hasNextPage = true;
  bool isLoadingMoreRunning = false;
  List<Passengers> morePassengers = [];
  void loadMoreData() {
    print('from Load More');
    emit(AppLoadMoreDataLoadingState());
    if (hasNextPage && !isLoadingMoreRunning && !isFirstLoadRunning) {
      morePassengers = [];
      isLoadingMoreRunning = true;
      currentPage++;
      DioHelper.getData(url: EndPoints.passenger, query: {
        'page': currentPage,
        'size': size,
      }).then((value)async{
        await value.data['data'].forEach((element) {
          morePassengers.add(Passengers.fromJson(element));
          print('more found');
        });
        if(morePassengers.isNotEmpty){
          passengers.addAll(morePassengers);
          print('more loaded successfully');
        }else{
          print('done');
          hasNextPage = false;
        }
        emit(AppLoadMoreDataSuccessState());
      }).catchError((error){
        debugPrint('Error in load more data =====> ${error.toString()}');
        emit(AppLoadMoreDataErrorState());
      });
      isLoadingMoreRunning = false;
    }
  }

}
