import 'package:alison/ui/contacts_list/contact_tile.dart';
import 'package:alison/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:alison/data/contact.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactsListPage extends StatefulWidget {
  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  final faker = Faker();

  late List<Contact> _contacts;

  // @override
  // void initState() {
  //   super.initState();
  //   _contacts = List.generate(50, (index) {
  //     final f = Faker();
  //     final firstName = f.person.firstName();
  //     final lastName = f.person.lastName();
  //     return Contact(
  //       name: '$firstName $lastName',
  //       email: f.internet.freeEmail(),
  //       phoneNumber: f.randomGenerator.integer(1000000).toString(),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ScopedModelDescendant<ContactsModel>(
        builder: (context, child, model) {
          return ListView.builder(
            itemCount: model.contacts.length,
          )
          },
        child: ListView.builder(
          itemCount: _contacts.length,
          itemBuilder: (context, index) {
            return ContactTile(
              contact: _contacts[index],
              onFavoriteToggle: () {
                setState(() {
                  _contacts[index].isFavorite = !_contacts[index].isFavorite;
                  _contacts.sort((a, b) {
                    if (a.isFavorite && !b.isFavorite) return -1;
                    if (!a.isFavorite && b.isFavorite) return 1;
                    return 0;
                  });
                });
              }, onFavoritePressed: () {  },
            );
          },
        ),
      ),
    );
  }
}
