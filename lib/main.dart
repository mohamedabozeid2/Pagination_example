import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pagination/app.dart';

import 'core/api/dio_helper.dart';
import 'core/bloc_observer/bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  BlocOverrides.runZoned(
        () {
      runApp(PaginationApp());
      // Use blocs...
    },
    blocObserver: MyBlocObserver(),
  );
}


