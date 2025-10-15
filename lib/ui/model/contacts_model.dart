import 'dart:typed_data';
import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../data/contact.dart';

class ContactsModel extends Model {
  final List<Contact> _contacts = List.generate(8, (index) {
    final f = Faker();
    final first = f.person.firstName();
    final last = f.person.lastName();
    return Contact(
      name: '$first $last',
      email: f.internet.email(),
      phoneNumber: f.phoneNumber.us(),
    );
  });

  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
    _sortContacts();
    notifyListeners();
  }

  void toggleFavorite(int index) {
    _contacts[index].isFavorite = !_contacts[index].isFavorite;
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
