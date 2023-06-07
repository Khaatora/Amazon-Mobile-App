part of 'home_cubit.dart';

@immutable
class HomeState {
  final LoadingState loadingState;
  final BottomNavScreen bottomNavScreen;
  final int currentIndex;
  final String message;

  const HomeState({
    this.loadingState = LoadingState.init,
    this.bottomNavScreen = BottomNavScreen.a,
    this.currentIndex = 0,
    this.message = "",
  });

  HomeState copyWith({
    LoadingState? loadingState,
    BottomNavScreen? bottomNavScreen,
    int? currentIndex,
    String? message,
  }) {
    return HomeState(
      loadingState: loadingState ?? this.loadingState,
      bottomNavScreen: bottomNavScreen ?? this.bottomNavScreen,
      currentIndex: currentIndex ?? this.currentIndex,
      message: message ?? this.message,
    );
  }
}
