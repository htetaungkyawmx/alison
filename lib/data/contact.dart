import 'dart:typed_data';

class Contact {
  String name;
  String email;
  String phoneNumber;
  bool isFavorite;
  Uint8List? image;
  String? imageUrl;

  Contact({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.isFavorite = false,
    this.image,
    this.imageUrl,
  });
}
