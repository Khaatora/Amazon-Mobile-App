import 'package:amazon_e_commerce_clone/core/global/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import 'components/address_bar.dart';
import 'components/carousel_imgs_slider.dart';
import 'components/categories_bar.dart';
import 'components/deal_of_the_day_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {

                            },
                            child: const Padding(padding: EdgeInsets.only(left: 8), child: Icon(Icons.search, color: Colors.black, size: 24,),),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 8),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide.none
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(color: Colors.black38, width: 1.0),
                          ),
                          hintText: "Search Amazon.in",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    )
                  ),
                ),
              ],
            ),
          )),
      body: SingleChildScrollView(

        child: Column(
          children: const [
            AddressBar(),
            SizedBox(height: 8),
            CategoriesBar(),
            CarouselImgsSlider(),
            DealOfTheDayWidget(),
          ],
        ),
      ),
    );
  }
}

