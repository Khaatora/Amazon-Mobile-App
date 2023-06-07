class AppUser {
  final String email;
  final String name;
  final String token;
  final String type;
  final String address;

  const AppUser({
    this.email = "",
    this.token = "",
    this.type = "",
    this.address = "",
    this.name = ""
  });
}