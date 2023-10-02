part of 'analytics_cubit.dart';

class AnalyticsState extends Equatable {
  final LoadingState getEarningsLoadingState;
  final String message;
  final LoadingState loadingState;
  final GetEarningsResponse? getEarningsResponse;

  const AnalyticsState({
    this.getEarningsLoadingState = LoadingState.loading,
    this.message = '',
    this.loadingState = LoadingState.init,
    this.getEarningsResponse,
  });

  AnalyticsState copyWith(
      {LoadingState? getEarningsLoadingState,
      String? message,
      LoadingState? loadingState,
      GetEarningsResponse? getEarningsResponse}) {
    return AnalyticsState(
      getEarningsLoadingState:
      getEarningsLoadingState ?? this.getEarningsLoadingState,
      message: message ?? this.message,
      loadingState: loadingState ?? this.loadingState,
      getEarningsResponse: getEarningsResponse ?? this.getEarningsResponse,
    );
  }

  @override
  List get props => [
        getEarningsLoadingState,
        message,
        loadingState,
        getEarningsResponse,
      ];
}
