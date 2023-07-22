class ApiPaths{

  static const String apiKey = "";
  static const String baseUrl = "http://192.168.1.15:3000/api";
  // paths
  static const String signupPath = "/signup";
  static const String signinPath = "/signin";
  static const String verifyTokenPath = "/validateToken";
  static const String getUserDataPath = "/";
  static const String adminAddProduct = "/admin/add-product";


  static String signupUrl() => "$baseUrl$signupPath";
  static String signinUrl() => "$baseUrl$signinPath";
  static String verifyTokenUrl() => "$baseUrl$verifyTokenPath";
  static String getUserDataUrl() => "$baseUrl$getUserDataPath";
  static String adminAddProductUrl() => "$baseUrl$adminAddProduct";


}