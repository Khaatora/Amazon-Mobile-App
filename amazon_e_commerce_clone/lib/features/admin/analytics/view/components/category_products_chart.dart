import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CategoryProductsChart extends StatelessWidget {
  const CategoryProductsChart({super.key, required this.barCharData});
  final BarChartData barCharData;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      barCharData,
    );
  }
}
