import 'package:amazon_e_commerce_clone/core/errors/exceptions/server_exception.dart';


class GenericAPIException extends ServerException{

  const GenericAPIException([super.message = "something went wrong"]);
}
class InvalidCredentialsException extends ServerException{
  // create your own Exception and extend this class if you want to throw an Exception
  const InvalidCredentialsException([super.message = "invalid credentials"]);
}
class InternalServerException extends ServerException{
  // create your own Exception and extend this class if you want to throw an Exception
  const InternalServerException([super.message = "Internal Server Error"]);
}