import 'package:alison/data/contact.dart';
import 'package:faker/faker.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactsModel extends Model{
  List<Contact> _contacts = List.generate(50, (index) {
      final f = Faker();
      final firstName = f.person.firstName();
      final lastName = f.person.lastName();
      return Contact(
        name: '$firstName $lastName',
        email: f.internet.freeEmail(),
        phoneNumber: f.randomGenerator.integer(1000000).toString(),
      );
    });

  List<Contact> get contacts => _contacts;

  void changeFavouriteStatus(int index) {
    _contacts [index].isFavorite = !_contacts[index].isFavorite;
     _contacts.sort((a, b) {
       if (a.isFavorite && !b.isFavorite) return -1;
       if (!a.isFavorite && b.isFavorite) return 1;
       return 0;
    });
  }
}
