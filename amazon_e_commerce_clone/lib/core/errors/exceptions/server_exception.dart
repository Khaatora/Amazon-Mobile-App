class ServerException implements Exception{
  final String message;
  // create your own Exception and extend this class if you want to throw an Exception
  const ServerException([this.message = "something went wrong"]);
}