import 'dart:developer';
import 'dart:io';

import 'package:amazon_e_commerce_clone/features/admin/products/repository/i_products_repository.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/errors/exceptions/api/login_exceptions.dart';
import '../../../../core/errors/exceptions/server_exception.dart';
import '../../../../core/services/services_locator.dart';
import 'store_product_response.dart';

class CloudinaryRemoteDataSource {

  Future<ProductParams> storeProduct(StoreProductImgsParams params) async {
    try {
      final cloudinaryInstance = CloudinaryPublic("dzc4cf4bi", "uftdofhb");
      List<String> imgUrls = [];
      for (File img in params.images) {
        log(params.name);
        CloudinaryResponse response = await cloudinaryInstance
            .uploadFile(CloudinaryFile.fromFile(img.path, folder: params.name));
        imgUrls.add(response.secureUrl);
      }
      ProductParams product = ProductParams(name: params.name,
        description: params.description,
        price: params.price,
        quantity: params.quantity,
        category: params.category,
        images: imgUrls,);
      return product;
    } catch (e) {
      rethrow;
    }
  }
}

class ServerRemoteDataSource{
  Future<StoreProductResponse> storeProductData(ProductParams params,String token) async {
    try {
      final response = await sl<Dio>().post(ApiPaths.adminAddProductUrl(), data: params.toJson(),options: Options(
          headers: {
            Headers.contentTypeHeader: "application/json; charset=UTF-8",
            "x-auth-token": token,
          }
      ));
      if(response.statusCode == 200){
        return StoreProductResponse.fromJson(response.data);
      }
      else{
        throw const InvalidTokenException();
      }
    } on DioError catch(error){
      log("${error.message}, stacktrace: ${error.stackTrace}");
      switch(error.response!.statusCode){
        case 500:
          throw InternalServerException(error.response?.data["error"]);
        case 401:
          throw InvalidTokenException(error.response?.data["msg"]);
        default:
          throw const GenericAPIException();
      }
    }
    catch (e) {
      log("$e");
      rethrow;
    }
  }
}
