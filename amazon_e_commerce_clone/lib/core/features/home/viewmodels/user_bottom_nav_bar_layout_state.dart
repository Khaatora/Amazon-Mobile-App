part of 'user_bottom_nav_bar_layout_cubit.dart';

@immutable
class UserBottomNavBarLayoutState {
  final LoadingState loadingState;
  final UserBottomNavScreen bottomNavScreen;
  final double bottomNavBarItemWidth;
  final double bottomNavBarItemBorderWidth;
  final int currentIndex;
  final String message;

  const UserBottomNavBarLayoutState({
    this.loadingState = LoadingState.init,
    this.bottomNavScreen = UserBottomNavScreen.a,
    this.currentIndex = 0,
    this.message = "",
    this.bottomNavBarItemWidth = 42.0,
    this.bottomNavBarItemBorderWidth = 5.0,
  });

  UserBottomNavBarLayoutState copyWith({
    LoadingState? loadingState,
    UserBottomNavScreen? bottomNavScreen,
    int? currentIndex,
    String? message,
  }) {
    return UserBottomNavBarLayoutState(
      loadingState: loadingState ?? this.loadingState,
      bottomNavScreen: bottomNavScreen ?? this.bottomNavScreen,
      currentIndex: currentIndex ?? this.currentIndex,
      message: message ?? this.message,
    );
  }
}
