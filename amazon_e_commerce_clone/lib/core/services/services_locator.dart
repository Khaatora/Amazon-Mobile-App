import 'package:amazon_e_commerce_clone/core/constants/api_constants.dart';
import 'package:amazon_e_commerce_clone/features/auth/models/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/auth/repository/auth_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/auth/repository/i_auth_repository.dart';
import 'package:amazon_e_commerce_clone/features/auth/view_models/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServicesLocator{

  void init(){

    // Dio
    sl.registerLazySingleton<Dio>(() => Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        contentType: "application/json; charset=UTF-8",
        connectTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    ));

    // Bloc/Cubit
    sl.registerFactory<AuthCubit>(() => AuthCubit(sl()));

    // Repository
    sl.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(sl()));

    // Data Source
    sl.registerLazySingleton<RemoteDataSource>(() => APIRemoteDataSource());
  }
}