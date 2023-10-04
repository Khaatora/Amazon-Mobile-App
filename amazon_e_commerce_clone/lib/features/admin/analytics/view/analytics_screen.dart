import 'package:amazon_e_commerce_clone/core/constants/app_categories.dart';
import 'package:amazon_e_commerce_clone/core/constants/app_colors.dart';
import 'package:amazon_e_commerce_clone/core/features/main/view_model/main_cubit.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/loader.dart';
import 'package:amazon_e_commerce_clone/core/global/components/reusable_components/reloader.dart';
import 'package:amazon_e_commerce_clone/core/global/size_config.dart';
import 'package:amazon_e_commerce_clone/features/admin/analytics/view/components/category_products_chart.dart';
import 'package:amazon_e_commerce_clone/features/admin/analytics/viewmodels/analytics_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnalyticsView();
  }
}

class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AnalyticsCubit, AnalyticsState>(
        buildWhen: (previous, current) =>
            current.getEarningsResponse != previous.getEarningsResponse,
        builder: (context, state) {
          const SizeConfig().init(context);
          switch (state.getEarningsLoadingState) {
            case LoadingState.init:
            case LoadingState.loading:
            case LoadingState.loaded:
              return state.getEarningsResponse == null
                  ? const Loader()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "total earnings: \$${state.getEarningsResponse!.totalEarnings}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                            height: SizeConfig.safeScreenHeight * 0.4,
                            margin: const EdgeInsets.only(right: 8.0),
                            child: CategoryProductsChart(
                              barCharData: BarChartData(
                                  titlesData: FlTitlesData(
                                    show: true,
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                      axisNameSize: 20,
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: _bottomTitles,
                                        reservedSize: 60,
                                      ),
                                    ),
                                  ),
                                  gridData: const FlGridData(
                                    show: false,
                                  ),
                                  barGroups: [
                                    BarChartGroupData(
                                      x: 0,
                                      barRods: [
                                        BarChartRodData(
                                          toY: state.getEarningsResponse!
                                              .mobileEarnings.earnings,
                                          width: 15,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0)),
                                        )
                                      ],
                                    ),
                                    BarChartGroupData(x: 1, barRods: [
                                      BarChartRodData(
                                        toY: state.getEarningsResponse!
                                            .fashionEarnings.earnings,
                                        width: 15,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0)),
                                      )
                                    ]),
                                    BarChartGroupData(x: 2, barRods: [
                                      BarChartRodData(
                                        toY: state.getEarningsResponse!
                                            .booksEarnings.earnings,
                                        width: 15,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0)),
                                      )
                                    ]),
                                    BarChartGroupData(x: 3, barRods: [
                                      BarChartRodData(
                                        toY: state.getEarningsResponse!
                                            .appliancesEarnings.earnings,
                                        width: 15,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0)),
                                      )
                                    ]),
                                    BarChartGroupData(x: 4, barRods: [
                                      BarChartRodData(
                                        toY: state.getEarningsResponse!
                                            .essentialsEarnings.earnings,
                                        width: 15,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0)),
                                      )
                                    ]),
                                  ],
                                  borderData: FlBorderData(
                                      border: const Border(
                                          top: BorderSide.none,
                                          right: BorderSide.none,
                                          left: BorderSide(width: 2),
                                          bottom: BorderSide(width: 2)))),
                            ))
                      ],
                    );
            case LoadingState.error:
              return ReloaderWidget(
                callBack: () => AnalyticsCubit.get(context)
                    .getEarnings(MainCubit.get(context).state.user.token),
              );
          }
        },
      ),
    );
  }

  Widget _bottomTitles(double value, TitleMeta meta) {
    final Widget text = Text(
      AppCategories.categoriesList[value.toInt()],
      style: const TextStyle(
        color: AppColors.secondaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      //margin top
      fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
      angle: -0.5,
      child: text,
    );
  }
}
