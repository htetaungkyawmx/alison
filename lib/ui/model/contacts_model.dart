import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:alison/data/contact.dart';

class ContactsModel extends Model {
  // Initialize with 20 random fake contacts
  final List<Contact> _contacts = List.generate(20, (index) {
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

  /// Toggle favorite and sort so favorites appear on top
  void toggleFavorite(int index) {
    _contacts[index].isFavorite = !_contacts[index].isFavorite;
    _contacts.sort((a, b) {
      if (a.isFavorite && !b.isFavorite) return -1;
      if (!a.isFavorite && b.isFavorite) return 1;
      return a.name.compareTo(b.name);
    });
    notifyListeners();
  }

  /// Add a new contact
  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }
}
