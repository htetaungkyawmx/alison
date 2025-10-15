import 'package:alison/data/contact.dart';
import 'package:alison/ui/contact/contact_create_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: CupertinoColors.systemBackground,
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Contacts'),
        backgroundColor: CupertinoColors.systemBackground,
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Main Content
            Column(
              children: [
                Expanded(
                  child: ScopedModelDescendant<ContactsModel>(
                    builder: (context, child, model) {
                      // Group contacts by first letter
                      final Map<String, List<Contact>> groupedContacts = {};
                      
                      for (var contact in model.contacts) {
                        final firstLetter = contact.name[0].toUpperCase();
                        if (!groupedContacts.containsKey(firstLetter)) {
                          groupedContacts[firstLetter] = [];
                        }
                        groupedContacts[firstLetter]!.add(contact);
                      }

                      // Sort the groups
                      final sortedLetters = groupedContacts.keys.toList()..sort();

                      // Filter if search query exists
                      final filteredGroups = <String, List<Contact>>{};
                      if (query.isEmpty) {
                        filteredGroups.addAll(groupedContacts);
                      } else {
                        for (var letter in sortedLetters) {
                          final filtered = groupedContacts[letter]!.where((contact) =>
                            contact.name.toLowerCase().contains(query.toLowerCase()) ||
                            contact.phoneNumber.contains(query) ||
                            contact.email.toLowerCase().contains(query.toLowerCase())
                          ).toList();
                          if (filtered.isNotEmpty) {
                            filteredGroups[letter] = filtered;
                          }
                        }
                      }

                      if (filteredGroups.isEmpty) {
                        return _buildEmptyState();
                      }

                      return Scrollbar(
                        controller: _scrollController,
                        child: ListView.builder(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 60),
                          itemCount: filteredGroups.length,
                          itemBuilder: (context, index) {
                            final letter = filteredGroups.keys.toList()[index];
                            final contacts = filteredGroups[letter]!;
                            
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Section Header
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 6,
                                  ),
                                  color: CupertinoColors.systemGrey6,
                                  child: Text(
                                    letter,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                ),
                                // Contacts in this section
                                ...contacts.map((contact) {
                                  final contactIndex = model.contacts.indexOf(contact);
                                  return ContactTile(
                                    contact: contact,
                                    index: contactIndex,
                                  );
                                }),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                
                // Search Bar at Bottom
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBackground,
                    border: Border(
                      top: BorderSide(
                        color: CupertinoColors.systemGrey5,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: CupertinoSearchTextField(
                    placeholder: 'Search',
                    onChanged: (value) => setState(() => query = value),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),

            // Floating Add Button
            Positioned(
              bottom: 80,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemBlue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CupertinoButton(
                  color: CupertinoColors.systemBlue,
                  padding: const EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(28),
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
                    color: CupertinoColors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.person,
            size: 60,
            color: CupertinoColors.systemGrey3,
          ),
          const SizedBox(height: 16),
          Text(
            'No Contacts',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            query.isEmpty
                ? 'Add your first contact'
                : 'No results for "$query"',
            style: TextStyle(
              fontSize: 16,
              color: CupertinoColors.systemGrey2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}