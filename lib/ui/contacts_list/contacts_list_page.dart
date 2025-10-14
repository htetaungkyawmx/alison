import 'package:alison/ui/contact/contact_create_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:alison/ui/model/contacts_model.dart';
import 'package:alison/ui/contacts_list/contact_tile.dart';

class ContactsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Contacts'),
          ),
          body: ListView.builder(
            itemCount: model.contacts.length,
            itemBuilder: (context, index) {
              return ContactTile(contactIndex: index);
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigate to the create contact page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ContactCreatePage()),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
