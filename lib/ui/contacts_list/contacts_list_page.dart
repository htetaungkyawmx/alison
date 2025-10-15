import 'package:alison/ui/contact/contact_create_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:alison/ui/model/contacts_model.dart';
import 'package:alison/ui/contacts_list/contact_tile.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({super.key});

  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  String query = '';
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          'Contacts',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        backgroundColor: CupertinoColors.systemBackground.withOpacity(0.9),
        border: null,
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
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.add,
                color: CupertinoColors.systemBlue,
                size: 22,
              ),
              SizedBox(width: 4),
              Text(
                'Add',
                style: TextStyle(
                  color: CupertinoColors.systemBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground,
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: CupertinoSearchTextField(
                placeholder: 'Search contacts...',
                onChanged: (value) => setState(() => query = value),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: CupertinoColors.systemGrey6,
                ),
              ),
            ),

            // Stats Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              color: CupertinoColors.systemBackground,
              child: ScopedModelDescendant<ContactsModel>(
                builder: (context, child, model) {
                  final totalContacts = model.contacts.length;
                  final favoriteContacts = model.contacts.where((c) => c.isFavorite).length;
                  
                  return Row(
                    children: [
                      _buildStatItem('$totalContacts', 'Total'),
                      const SizedBox(width: 20),
                      _buildStatItem('$favoriteContacts', 'Favorites'),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.person_2_fill,
                              color: CupertinoColors.systemBlue,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Contacts',
                              style: TextStyle(
                                color: CupertinoColors.systemBlue,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // Contact List
            Expanded(
              child: ScopedModelDescendant<ContactsModel>(
                builder: (context, child, model) {
                  final filteredContacts = model.contacts
                      .where((c) =>
                          c.name.toLowerCase().contains(query.toLowerCase()) ||
                          c.phoneNumber.contains(query) ||
                          c.email.toLowerCase().contains(query.toLowerCase()))
                      .toList();

                  if (filteredContacts.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: filteredContacts.length,
                    itemBuilder: (context, index) {
                      final contactIndex = model.contacts.indexOf(filteredContacts[index]);
                      return ContactTile(index: contactIndex);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: CupertinoColors.label,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: CupertinoColors.systemGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6,
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.person_circle,
              size: 50,
              color: CupertinoColors.systemGrey2,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No contacts found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            query.isEmpty
                ? 'Add your first contact to get started'
                : 'No results for "$query"',
            style: TextStyle(
              fontSize: 16,
              color: CupertinoColors.systemGrey2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          if (query.isEmpty)
            CupertinoButton(
              color: CupertinoColors.systemBlue,
              borderRadius: BorderRadius.circular(12),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => const ContactCreatePage(),
                  ),
                );
              },
              child: const Text('Create Contact'),
            ),
        ],
      ),
    );
  }
}