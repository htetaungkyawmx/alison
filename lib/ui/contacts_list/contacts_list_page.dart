import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../data/contact.dart';
import '../model/contacts_model.dart';
import '../contact/contact_create_page.dart';
import 'contact_tile.dart';

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
        // Filter contacts based on search query
        final filtered = model.contacts
            .where((c) =>
        c.name.toLowerCase().contains(query.toLowerCase()) ||
            c.phoneNumber.contains(query))
            .toList();

        // Group contacts alphabetically
        final Map<String, List<Contact>> grouped = {};
        for (var c in filtered) {
          final key = c.name.isNotEmpty ? c.name[0].toUpperCase() : '#';
          grouped.putIfAbsent(key, () => []).add(c);
        }
        final sortedKeys = grouped.keys.toList()..sort();

        return CupertinoPageScaffold(
          backgroundColor: CupertinoColors.systemGroupedBackground,
          child: CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                backgroundColor: CupertinoColors.systemGroupedBackground,
                border: null,
                largeTitle: const Text('Contacts'),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const ContactCreatePage(),
                      ),
                    );
                  },
                  child: const Icon(
                    CupertinoIcons.add,
                    size: 28,
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SearchHeader(
                  onChanged: (val) => setState(() => query = val),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, i) {
                    final key = sortedKeys[i];
                    final contacts = grouped[key]!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 5),
                          child: Text(
                            key,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ),
                        CupertinoListSection.insetGrouped(
                          hasLeading: false,
                          backgroundColor:
                          CupertinoColors.systemGroupedBackground,
                          children: contacts.map((c) {
                            final index = model.contacts.indexOf(c);
                            return ContactTile(index: index);
                          }).toList(),
                        ),
                      ],
                    );
                  },
                  childCount: sortedKeys.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SearchHeader extends SliverPersistentHeaderDelegate {
  final ValueChanged<String> onChanged;

  _SearchHeader({required this.onChanged});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: CupertinoColors.systemGroupedBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CupertinoSearchTextField(
        placeholder: 'Search',
        onChanged: onChanged,
      ),
    );
  }

  @override
  double get maxExtent => 56;
  @override
  double get minExtent => 56;
  @override
  bool shouldRebuild(covariant _SearchHeader oldDelegate) => false;
}
