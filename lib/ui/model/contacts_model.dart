import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../data/contact.dart';

class ContactsModel extends Model {
  final List<Contact> _contacts = [];

  ContactsModel() {
    _generateDummyContacts();
  }

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

  void _generateDummyContacts() {
    final faker = Faker();
    final avatarBase = 'https://api.dicebear.com/9.x/avataaars/png?seed=';

    for (int i = 0; i < 100; i++) {
      final firstName = faker.person.firstName();
      final lastName = faker.person.lastName();
      final fullName = '$firstName $lastName';

      _contacts.add(Contact(
        name: fullName,
        email: faker.internet.email(),
        phoneNumber: faker.phoneNumber.us(),
        imageUrl: '$avatarBase$firstName$lastName',
      ));
    }

    _sortContacts();
  }
}
