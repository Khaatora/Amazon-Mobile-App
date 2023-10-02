import 'package:amazon_e_commerce_clone/core/constants/api_paths.dart';
import 'package:amazon_e_commerce_clone/core/features/home/viewmodels/admin_bottom_nav_bar_layout_cubit.dart';
import 'package:amazon_e_commerce_clone/features/admin/analytics/models/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/admin/analytics/repository/analytics_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/admin/analytics/repository/i_analytics_repository.dart';
import 'package:amazon_e_commerce_clone/features/admin/orders/models/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/admin/orders/repository/i_orders_repository.dart';
import 'package:amazon_e_commerce_clone/features/admin/orders/repository/orders_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/models/remote_data_sources.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/repository/i_products_repository.dart';
import 'package:amazon_e_commerce_clone/features/admin/products/repository/products_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/auth/models/local_data_source.dart';
import 'package:amazon_e_commerce_clone/features/auth/repository/auth_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/auth/repository/i_auth_repository.dart';
import 'package:amazon_e_commerce_clone/features/auth/view_models/auth_cubit.dart';
import 'package:amazon_e_commerce_clone/features/order_details/model/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/order_details/repository/i_order_details_repository.dart';
import 'package:amazon_e_commerce_clone/features/order_details/repository/order_details_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/order_details/view_model/order_details_cubit.dart';
import 'package:amazon_e_commerce_clone/features/user/address/model/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/user/address/repository/address_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/user/address/repository/i_address_repository.dart';
import 'package:amazon_e_commerce_clone/features/user/address/view_model/address_cubit.dart';
import 'package:amazon_e_commerce_clone/features/user/cart/models/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/user/cart/repository/cart_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/user/cart/repository/i_cart_repository.dart';
import 'package:amazon_e_commerce_clone/features/user/cart/view_models/cart_cubit.dart';
import 'package:amazon_e_commerce_clone/features/user/home/models/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/user/home/repository/home_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/user/home/repository/i_home_repository.dart';
import 'package:amazon_e_commerce_clone/features/user/home/view_models/category_cubit.dart';
import 'package:amazon_e_commerce_clone/features/user/product_details/model/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/user/product_details/repository/i_product_details_repository.dart';
import 'package:amazon_e_commerce_clone/features/user/product_details/repository/product_details_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/user/product_details/view_model/product_details_cubit.dart';
import 'package:amazon_e_commerce_clone/features/user/profile/models/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/user/profile/repository/i_profile_repository.dart';
import 'package:amazon_e_commerce_clone/features/user/profile/repository/profile_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/user/profile/view_models/profile_cubit.dart';
import 'package:amazon_e_commerce_clone/features/user/search/model/remote_data_source.dart';
import 'package:amazon_e_commerce_clone/features/user/search/repository/i_search_repository.dart';
import 'package:amazon_e_commerce_clone/features/user/search/repository/search_repository_impl.dart';
import 'package:amazon_e_commerce_clone/features/user/search/view_model/search_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/admin/products/viewmodels/add_products_cubit.dart';
import '../../features/user/home/view_models/user_home_cubit.dart';
import '../features/home/viewmodels/user_bottom_nav_bar_layout_cubit.dart';
import '../features/main/model/remote_data_source.dart';
import '../features/main/repository/i_main_repository.dart';
import '../features/main/repository/main_repository_impl.dart';
import '../features/main/view_model/main_cubit.dart';
import 'file_pickers/image_file_picker.dart';

final sl = GetIt.instance;

class ServicesLocator{

  const ServicesLocator();

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
    sl.registerLazySingleton<ImageFilePicker>(() => const FPImageFilePicker());

    // Repository
    sl.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(sl<RemoteDataSource>(), sl<LocalDataSource>()));
    sl.registerLazySingleton<IMainRepository>(() => MainRepositoryImpl(sl(), sl()));
    sl.registerLazySingleton<IProductsRepository>(() => ProductsRepositoryImpl(sl(),sl()));
    sl.registerLazySingleton<IHomeRepository>(() => HomeRepositoryImpl(sl<HomeRemoteDataSource>()));
    sl.registerLazySingleton<ISearchRepository>(() => SearchRepositoryImpl(sl<SearchRemoteDataSource>()));
    sl.registerLazySingleton<IProductDetailsRepository>(() => ProductDetailsRepositoryImpl(sl<ProductDetailsRemoteDataSource>()));
    sl.registerLazySingleton<ICartRepository>(() => CartRepositoryImpl(sl<CartRemoteDataSource>()));
    sl.registerLazySingleton<IAddressRepository>(() => AddressRepositoryImpl(sl<AddressRemoteDataSource>()));
    sl.registerLazySingleton<IProfileRepository>(() => ProfileRepositoryImpl(sl<ProfileRemoteDataSource>()));
    sl.registerLazySingleton<IOrdersRepository>(() => OrdersRepositoryImpl(sl<OrdersRemoteDataSource>()));
    sl.registerLazySingleton<IOrderDetailsRepository>(() => OrderDetailsRepositoryImpl(sl<OrderDetailsRemoteDataSource>()));
    sl.registerLazySingleton<IAnalyticsRepository>(() => AnalyticsRepositoryImpl(sl<AnalyticsRemoteDataSource>()));

    // Data Source
    sl.registerLazySingleton<RemoteDataSource>(() => const APIRemoteDataSource());
    sl.registerLazySingleton<LocalDataSource>(() => const SharedPrefsLocalDataSource());
    sl.registerLazySingleton<CloudinaryRemoteDataSource>(() => const CloudinaryRemoteDataSource());
    sl.registerLazySingleton<ServerRemoteDataSource>(() => ServerRemoteDataSource());
    sl.registerLazySingleton<HomeRemoteDataSource>(() => const HomeRemoteDataSource());
    sl.registerLazySingleton<SearchRemoteDataSource>(() => const SearchRemoteDataSource());
    sl.registerLazySingleton<ProductDetailsRemoteDataSource>(() => const ProductDetailsRemoteDataSource());
    sl.registerLazySingleton<CartRemoteDataSource>(() => const CartRemoteDataSource());
    sl.registerLazySingleton<AddressRemoteDataSource>(() => const AddressRemoteDataSource());
    sl.registerLazySingleton<ProfileRemoteDataSource>(() => const ProfileRemoteDataSource());
    sl.registerLazySingleton<OrderDetailsRemoteDataSource>(() => const OrderDetailsRemoteDataSource());
    sl.registerLazySingleton<OrdersRemoteDataSource>(() => const OrdersRemoteDataSource());
    sl.registerLazySingleton<AnalyticsRemoteDataSource>(() => const AnalyticsRemoteDataSource());

    // Bloc/Cubit
    sl.registerFactory<AuthCubit>(() => AuthCubit(sl()));
    sl.registerLazySingleton<UserBottomNavBarLayoutCubit>(() => UserBottomNavBarLayoutCubit());
    sl.registerLazySingleton<AdminBottomNavBarLayoutCubit>(() => AdminBottomNavBarLayoutCubit());
    sl.registerFactory<AddProductsCubit>(() => AddProductsCubit(sl<ImageFilePicker>(), sl<IProductsRepository>()));
    sl.registerFactory<CategoryCubit>(() => CategoryCubit(sl<IHomeRepository>()));
    sl.registerFactory<SearchCubit>(() => SearchCubit(sl<ISearchRepository>()));
    sl.registerFactory<ProductDetailsCubit>(() => ProductDetailsCubit(sl<IProductDetailsRepository>()));
    sl.registerFactory<UserHomeCubit>(() => UserHomeCubit(sl<IHomeRepository>()));
    sl.registerFactory<CartCubit>(() => CartCubit(sl<ICartRepository>()));
    sl.registerFactory<AddressCubit>(() => AddressCubit(sl<IAddressRepository>()));
    sl.registerFactory<ProfileCubit>(() => ProfileCubit(sl<IProfileRepository>()));
    sl.registerFactory<OrderDetailsCubit>(() => OrderDetailsCubit(sl<IOrderDetailsRepository>()));
    await _initApp();


  }

  Future<void> _initSharedPrefs() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sl.registerSingleton<SharedPreferences>(sharedPref);
  }

  Future<void> _initApp() async {
    await sl.registerSingleton<MainCubit>(MainCubit(sl(),)).initState();

  }
}