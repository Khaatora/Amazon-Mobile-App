class ServerException implements Exception{
  final String message;
  // create your own Exception and extend this class if you want to throw an Exception
  const ServerException([this.message = "something went wrong"]);
}

class InvalidCredentialsException extends ServerException{
  const InvalidCredentialsException([super.message = "invalid credentials"]);
}
class InternalServerException extends ServerException{
  const InternalServerException([super.message = "Internal Server Error"]);
}
class InvalidTokenException extends ServerException{
  const InvalidTokenException([super.message = "Invalid Token"]);
}
class OutOfStockException extends ServerException{
  const OutOfStockException([super.message = "Out Of Stock!"]);
}