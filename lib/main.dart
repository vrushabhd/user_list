import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'services/api_service.dart';
import 'blocs/user_bloc.dart';
import 'screens/user_list_screen.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter User List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => UserBloc(apiService: getIt<ApiService>())
          ..add(LoadCachedUsers())
          ..add(FetchUsers()),
        child: UserListScreen(),
      ),
    );
  }
}
