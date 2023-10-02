import 'package:amazon_e_commerce_clone/core/constants/app_routes.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/global/size_config.dart';
import 'package:amazon_e_commerce_clone/features/user/home/view_models/user_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/services_locator.dart';
import 'components/address_bar.dart';
import 'components/carousel_imgs_slider.dart';
import 'components/categories_bar.dart';
import 'components/deal_of_the_day_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<UserHomeCubit>()
          ..getDealOfTheDay(MainCubit.get(context).state.user.token),
        child: const HomeView());
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.appBarGradient,
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.mic),
              ),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      height: 42,
                      margin: const EdgeInsets.only(left: 16),
                      alignment: Alignment.topLeft,
                      child: Material(
                        borderRadius: BorderRadius.circular(7),
                        elevation: 1.0,
                        child: TextFormField(
                          textInputAction: TextInputAction.search,
                          controller: _searchController,
                          onFieldSubmitted: _navigateToSearchScreen,
                          decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {
                                _navigateToSearchScreen(_searchController.text);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(
                                  Icons.search,
                                  color: AppColors.black,
                                  size: 24,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 8),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1.0),
                            ),
                            hintText: "Search Amazon.in",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          )),
      body: const Column(
        children: [
          AddressBar(),
          SizedBox(height: 8),
          CategoriesBar(),
          CarouselImgsSlider(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
              child: DealOfTheDayWidget(),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSearchScreen(String query) {
    if(query.isNotEmpty){
      Navigator.pushNamed(context, AppRoutes.searchScreen, arguments: query);
    }
  }
}
