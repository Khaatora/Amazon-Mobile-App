import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../features/auth/models/local_data_source.dart';
import '../model/app_user.dart';
import '../repository/i_main_repository.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final LocalDataSource localDataSource;
  final IMainRepository mainRepository;

  MainCubit(this.localDataSource, this.mainRepository)
      : super(const MainState());

  static MainCubit get (context) => BlocProvider.of<MainCubit>(context);

  Future<void> initState() async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    final String tempToken = await localDataSource.getToken();
    final result = await mainRepository.verifyToken(tempToken);
    result.fold(
        (l) => emit(state.copyWith(
              token: tempToken,
              loadingState: LoadingState.error,
              message: l.message,
            )),
        (r) => emit(state.copyWith(
              token: tempToken,
              loadingState: LoadingState.loaded,
              type: r.user.type,
              address: r.user.address,
              email: r.user.email,
              name: r.user.name,
            )));
  }

  void setToken(String token) {
    state.copyWith(
      token: token,
    );
  }

  void setEmail(String Email) {
    state.copyWith(
      token: Email,
    );
  }

  void setType(String type) {
    state.copyWith(
      token: type,
    );
  }

  void setAddress(String address) {
    state.copyWith(
      token: address,
    );
  }
}
