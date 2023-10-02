part of 'admin_bottom_nav_bar_layout_cubit.dart';

class AdminBottomNavBarLayoutState extends Equatable {
  final LoadingState loadingState;
  final AdminBottomNavScreen bottomNavScreen;
  final double bottomNavBarItemWidth;
  final double bottomNavBarItemBorderWidth;
  final int currentIndex;
  final String message;

  const AdminBottomNavBarLayoutState({
    this.loadingState = LoadingState.init,
    this.bottomNavScreen = AdminBottomNavScreen.Home,
    this.currentIndex = 0,
    this.message = "",
    this.bottomNavBarItemWidth = 42.0,
    this.bottomNavBarItemBorderWidth = 5.0,
  });

  AdminBottomNavBarLayoutState copyWith({
    LoadingState? loadingState,
    AdminBottomNavScreen? bottomNavScreen,
    int? currentIndex,
    String? message,
  }) {
    return AdminBottomNavBarLayoutState(
      loadingState: loadingState ?? this.loadingState,
      bottomNavScreen: bottomNavScreen ?? this.bottomNavScreen,
      currentIndex: currentIndex ?? this.currentIndex,
      message: message ?? this.message,
    );
  }


  @override
  List<Object> get props => [
    loadingState,
    bottomNavScreen,
    bottomNavBarItemWidth,
    bottomNavBarItemBorderWidth,
    currentIndex,
    message,
  ];
}
