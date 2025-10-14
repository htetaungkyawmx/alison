import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:alison/data/contact.dart';

class ContactsModel extends Model {
  final List<Contact> _contacts = List.generate(50, (index) {
    final f = Faker();
    final firstName = f.person.firstName();
    final lastName = f.person.lastName();
    return Contact(
      name: '$firstName $lastName',
      email: f.internet.email(),
      phoneNumber: f.phoneNumber.us(),
    );
  });

  List<Contact> get contacts => _contacts;

  /// Toggle a contact's favorite status and sort list so favorites come first
  void toggleFavorite(int index) {
    _contacts[index].isFavorite = !_contacts[index].isFavorite;
    _contacts.sort((a, b) {
      if (a.isFavorite && !b.isFavorite) return -1;
      if (!a.isFavorite && b.isFavorite) return 1;
      return 0;
    });
    notifyListeners(); // 🔥 Notify all widgets to rebuild
  }

  /// Add a new contact to the list
  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }
}
