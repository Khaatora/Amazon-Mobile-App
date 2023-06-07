import 'package:amazon_e_commerce_clone/core/errors/exceptions/server_exception.dart';


class GenericAPIException extends ServerException{

  const GenericAPIException([super.message = "something went wrong"]);
}