import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:alison/data/contact.dart';

class ContactsModel extends Model {
  final List<Contact> _contacts = List.generate(15, (index) {
    final f = Faker();
    final first = f.person.firstName();
    final last = f.person.lastName();
    return Contact(
      name: '$first $last',
      email: f.internet.email(),
      phoneNumber: f.phoneNumber.us(),
      isFavorite: index % 4 == 0,
      photoUrl: 'https://i.pravatar.cc/200?u=$index${first}${last}',
      createdAt: DateTime.now().subtract(Duration(days: index * 2)),
    );
  });

  List<Contact> get contacts => _contacts;

  void toggleFavorite(int index) {
    _contacts[index].isFavorite = !_contacts[index].isFavorite;
    _sortContacts();
    notifyListeners();
  }

  void addContact(Contact contact) {
    _contacts.add(contact.copyWith(createdAt: DateTime.now()));
    _sortContacts();
    notifyListeners();
  }

  void _sortContacts() {
    _contacts.sort((a, b) {
      if (a.isFavorite && !b.isFavorite) return -1;
      if (!a.isFavorite && b.isFavorite) return 1;
      return a.name.compareTo(b.name);
    });
  }
}

extension ContactCopyWith on Contact {
  Contact copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    bool? isFavorite,
    String? photoUrl,
    DateTime? createdAt,
  }) {
    return Contact(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isFavorite: isFavorite ?? this.isFavorite,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}