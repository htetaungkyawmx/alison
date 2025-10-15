class Contact {
  String name;
  String email;
  String phoneNumber;
  bool isFavorite;
  String? photoUrl;

  Contact({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.isFavorite = false,
    this.photoUrl,
  });
}