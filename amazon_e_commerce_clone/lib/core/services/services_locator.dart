import 'package:amazon_e_commerce_clone/core/constants/api_paths.dart';
import 'package:amazon_e_commerce_clone/core/features/home/viewmodels/admin_bottom_nav_bar_layout_cubit.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/models/remote_data_sources.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/repository/i_products_repository.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/repository/products_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/auth/models/local_data_source.dart';
import 'package:amazon_e_commerce_clone/features/auth/repository/auth_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/auth/repository/i_auth_repository.dart';
import 'package:amazon_e_commerce_clone/features/auth/view_models/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/admin/products/viewmodels/add_products_cubit.dart';
import '../features/home/viewmodels/user_bottom_nav_bar_layout_cubit.dart';
import '../features/main/model/remote_data_source.dart';
import '../features/main/repository/i_main_repository.dart';
import '../features/main/repository/main_repository_impl.dart';
import '../features/main/view_model/main_cubit.dart';
import 'file_pickers/image_file_picker.dart';

final sl = GetIt.instance;

class ServicesLocator{

  Future<void> init() async{

    // Dio
    sl.registerLazySingleton<Dio>(() => Dio(
      BaseOptions(
        baseUrl: ApiPaths.baseUrl,
        contentType: "application/json; charset=UTF-8",
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ));

    // shared_prefs
    await _initSharedPrefs();
    
    // File Pickers
    sl.registerLazySingleton<ImageFilePicker>(() => FPImageFilePicker());

    // Repository
    sl.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(sl<RemoteDataSource>(), sl<LocalDataSource>()));
    sl.registerLazySingleton<IMainRepository>(() => MainRepositoryImpl(sl()));
    sl.registerLazySingleton<IProductsRepository>(() => ProductsRepositoryImpl(sl(),sl()));

    // Data Source
    sl.registerLazySingleton<RemoteDataSource>(() => APIRemoteDataSource());
    sl.registerLazySingleton<LocalDataSource>(() => SharedPrefsLocalDataSource());
    sl.registerLazySingleton<CloudinaryRemoteDataSource>(() => CloudinaryRemoteDataSource());
    sl.registerLazySingleton<ServerRemoteDataSource>(() => ServerRemoteDataSource());

    // Bloc/Cubit
    sl.registerFactory<AuthCubit>(() => AuthCubit(sl()));
    sl.registerLazySingleton<UserBottomNavBarLayoutCubit>(() => UserBottomNavBarLayoutCubit());
    sl.registerLazySingleton<AdminBottomNavBarLayoutCubit>(() => AdminBottomNavBarLayoutCubit());
    sl.registerFactory<AddProductsCubit>(() => AddProductsCubit(sl<ImageFilePicker>(), sl<IProductsRepository>()));
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