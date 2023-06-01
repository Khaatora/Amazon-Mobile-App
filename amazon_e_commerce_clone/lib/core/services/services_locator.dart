import 'package:amazon_e_commerce_clone/features/auth/view_models/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class ServicesLocator{

  void init(){

    // Bloc/Cubit
    sl.registerFactory<AuthCubit>(() => AuthCubit());

  }
}