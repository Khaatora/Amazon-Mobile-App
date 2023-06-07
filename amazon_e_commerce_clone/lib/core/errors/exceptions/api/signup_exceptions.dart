import '../server_exception.dart';

class GenericAPIException extends ServerException{

  const GenericAPIException([super.message = "something went wrong"]);
}