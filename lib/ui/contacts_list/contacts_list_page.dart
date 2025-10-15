import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import '../model/contacts_model.dart';
import '../contacts_list/contact_tile.dart';
import '../contact/contact_create_page.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({super.key});

  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        final filtered = model.contacts
            .where((c) =>
                c.name.toLowerCase().contains(query.toLowerCase()) ||
                c.phoneNumber.contains(query))
            .toList();

        final favorites = filtered.where((c) => c.isFavorite).toList();
        final others = filtered.where((c) => !c.isFavorite).toList();

        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Contacts'),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: CupertinoSearchTextField(
                        placeholder: 'Search',
                        onChanged: (val) => setState(() => query = val),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          if (favorites.isNotEmpty)
                            CupertinoListSection.insetGrouped(
                              header: const Text('Favorites'),
                              children: favorites.map((contact) {
                                final index =
                                    model.contacts.indexOf(contact);
                                return ContactTile(index: index);
                              }).toList(),
                            ),
                          CupertinoListSection.insetGrouped(
                            header: const Text('Contacts'),
                            children: others.map((contact) {
                              final index =
                                  model.contacts.indexOf(contact);
                              return ContactTile(index: index);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 25,
                  right: 25,
                  child: CupertinoButton(
                    color: CupertinoColors.activeBlue,
                    borderRadius: BorderRadius.circular(30),
                    padding: const EdgeInsets.all(14),
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
