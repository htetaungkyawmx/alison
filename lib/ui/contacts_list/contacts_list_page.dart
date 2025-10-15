import 'package:alison/ui/contact/contact_create_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:alison/ui/model/contacts_model.dart';
import 'package:alison/ui/contacts_list/contact_tile.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Contacts'),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: model.contacts.length,
                  itemBuilder: (context, index) {
                    return ContactTile(index: index);
                  },
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: CupertinoButton(
                    color: CupertinoColors.activeBlue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    borderRadius: BorderRadius.circular(25),
                    child: const Icon(CupertinoIcons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const ContactCreatePage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
