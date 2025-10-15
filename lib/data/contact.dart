import 'dart:typed_data';

class Contact {
  String name;
  String email;
  String phoneNumber;
  bool isFavorite;
  Uint8List? image;

  Contact({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.isFavorite = false,
    this.image,
  });
}
