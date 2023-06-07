import 'package:amazon_e_commerce_clone/core/constants/api_paths.dart';
import 'package:amazon_e_commerce_clone/features/auth/models/local_data_source.dart';
import 'package:amazon_e_commerce_clone/features/auth/repository/auth_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/auth/repository/i_auth_repository.dart';
import 'package:amazon_e_commerce_clone/features/auth/view_models/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/main/model/remote_data_source.dart';
import '../features/main/repository/i_main_repository.dart';
import '../features/main/repository/main_repository_impl.dart';
import '../features/main/view_model/main_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator{

  Future<void> init() async{

    // Dio
    sl.registerLazySingleton<Dio>(() => Dio(
      BaseOptions(
        baseUrl: ApiPaths.baseUrl,
        contentType: "application/json; charset=UTF-8",
        connectTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    ));

    // shared_prefs
    await _initSharedPrefs();

    // Repository
    sl.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(sl<RemoteDataSource>(), sl<LocalDataSource>()));
    sl.registerLazySingleton<IMainRepository>(() => MainRepositoryImpl(sl()));

    // Data Source
    sl.registerLazySingleton<RemoteDataSource>(() => APIRemoteDataSource());
    sl.registerLazySingleton<LocalDataSource>(() => SharedPrefsLocalDataSource());

    // Bloc/Cubit
    sl.registerFactory<AuthCubit>(() => AuthCubit(sl()));
    await _initApp();


  }

  Future<void> _initSharedPrefs() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(sharedPref);
  }

  Future<void> _initApp() async {
    await sl.registerSingleton<MainCubit>(MainCubit(sl(), sl())).initState();

  }
}