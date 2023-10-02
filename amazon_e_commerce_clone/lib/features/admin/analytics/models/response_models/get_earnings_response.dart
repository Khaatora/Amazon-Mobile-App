import 'package:amazon_e_commerce_clone/core/constants/app_categories.dart';
import 'package:amazon_e_commerce_clone/core/features/home/model/sale_model.dart';

class GetEarningsResponse {
  final double totalEarnings;
  final Sale mobileEarnings;
  final Sale essentialsEarnings;
  final Sale appliancesEarnings;
  final Sale booksEarnings;
  final Sale fashionEarnings;

  factory GetEarningsResponse.fromJson(Map<String, dynamic> json) {
    return GetEarningsResponse(
      totalEarnings: (json[GetEarningsApiKeys.totalEarnings] ?? 0).toDouble(),
      mobileEarnings: Sale(
        label: AppCategories.Mobiles,
        earnings: (json[GetEarningsApiKeys.mobileEarnings] ?? 0).toDouble(),
      ),
      essentialsEarnings: Sale(
        label: AppCategories.Essentials,
        earnings: (json[GetEarningsApiKeys.essentialsEarnings] ?? 0).toDouble(),
      ),
      appliancesEarnings: Sale(
        label: AppCategories.Appliances,
        earnings: (json[GetEarningsApiKeys.appliancesEarnings] ?? 0).toDouble(),
      ),
      booksEarnings: Sale(
        label: AppCategories.Books,
        earnings: (json[GetEarningsApiKeys.booksEarnings] ?? 0).toDouble(),
      ),
      fashionEarnings: Sale(
        label: AppCategories.Fashion,
        earnings: (json[GetEarningsApiKeys.fashionEarnings] ?? 0).toDouble(),
      ),
    );
  }

  const GetEarningsResponse({
    required this.totalEarnings,
    required this.mobileEarnings,
    required this.essentialsEarnings,
    required this.appliancesEarnings,
    required this.booksEarnings,
    required this.fashionEarnings,
  }); //
}

class GetEarningsApiKeys {
  static const String totalEarnings = "totalEarnings";
  static const String mobileEarnings = "mobileEarnings";
  static const String essentialsEarnings = "essentialsEarnings";
  static const String appliancesEarnings = "appliancesEarnings";
  static const String booksEarnings = "booksEarnings";
  static const String fashionEarnings = "fashionEarnings";
}
