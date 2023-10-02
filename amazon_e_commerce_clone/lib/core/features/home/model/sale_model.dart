import 'package:amazon_e_commerce_clone/core/constants/api_constants.dart';

class Sale {
  final String label;
  final double earnings;

  const Sale({
    required this.label,
    required this.earnings,
  });

  factory Sale.fromJson(Map<String, dynamic> json, String? label) {
    return Sale(
      label: label ?? json[ApiConstants.label],
      earnings: json[ApiConstants.earnings],
    );
  }
}
