class Contact {
  String name;
  String email;
  String phoneNumber;
  bool isFavorite;
  String? photoUrl;
  DateTime? createdAt;

  Contact({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.isFavorite = false,
    this.photoUrl,
    this.createdAt,
  });
}