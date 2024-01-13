import 'package:amazon_e_commerce_clone/core/utils/enums.dart';
import 'package:amazon_e_commerce_clone/features/admin/analytics/models/response_models/get_earnings_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/services_locator.dart';
import '../repository/i_analytics_repository.dart';

part 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  static AnalyticsCubit get(context) =>
      BlocProvider.of<AnalyticsCubit>(context);

  final IAnalyticsRepository analyticsRepository;

  AnalyticsCubit(this.analyticsRepository) : super(const AnalyticsState());

  void initState(String token) {
    getEarnings(token);
  }

  Future<void> getEarnings(String token) async {
    if (isClosed) return;
    emit(state.copyWith(
        getEarningsLoadingState: LoadingState.loading, message: ''));
    final result = await analyticsRepository.getEarnings(
        const GetAnalyticsParams(), token);
    if (isClosed) return;
    result.fold((l) {
      emit(state.copyWith(
          getEarningsLoadingState: LoadingState.error, message: l.message));
    }, (r) {
      emit(state.copyWith(
          getEarningsLoadingState: LoadingState.loaded,
          getEarningsResponse: r));
    });
  }

  @override
  Future<void> close() {
    sl.unregister<AnalyticsCubit>();
    return super.close();
  }
}
