import 'package:flutter/cupertino.dart';
import 'package:alison/data/contact.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:alison/ui/model/contacts_model.dart';

class ContactDetailPage extends StatelessWidget {
  final Contact contact;
  const ContactDetailPage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        final contactIndex = model.contacts.indexOf(contact);
        final updatedContact = model.contacts[contactIndex];
        
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(
              updatedContact.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: GestureDetector(
              onTap: () => model.toggleFavorite(contactIndex),
              child: Icon(
                updatedContact.isFavorite
                    ? CupertinoIcons.star_fill
                    : CupertinoIcons.star,
                color: updatedContact.isFavorite
                    ? CupertinoColors.systemYellow
                    : CupertinoColors.systemGrey,
                size: 22,
              ),
            ),
          ),
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      // Profile Photo
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CupertinoColors.systemGrey5,
                          image: updatedContact.photoUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(updatedContact.photoUrl!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: updatedContact.photoUrl == null
                            ? Center(
                                child: Text(
                                  updatedContact.name[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.w600,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(height: 20),
                      // Name
                      Text(
                        updatedContact.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      if (updatedContact.isFavorite)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              CupertinoIcons.star_fill,
                              color: CupertinoColors.systemYellow,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Favorite',
                              style: TextStyle(
                                color: CupertinoColors.systemYellow,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 40),
                      // Contact Info Section
                      CupertinoListSection.insetGrouped(
                        header: const Text('CONTACT INFORMATION'),
                        children: [
                          CupertinoListTile(
                            leading: const Icon(
                              CupertinoIcons.phone,
                              color: CupertinoColors.systemBlue,
                            ),
                            title: const Text(
                              'Phone',
                              style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              updatedContact.phoneNumber,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: const Icon(
                              CupertinoIcons.phone,
                              color: CupertinoColors.systemGrey3,
                            ),
                            onTap: () {
                              // In real app, use url_launcher
                            },
                          ),
                          CupertinoListTile(
                            leading: const Icon(
                              CupertinoIcons.mail,
                              color: CupertinoColors.systemBlue,
                            ),
                            title: const Text(
                              'Email',
                              style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              updatedContact.email,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: const Icon(
                              CupertinoIcons.mail,
                              color: CupertinoColors.systemGrey3,
                            ),
                            onTap: () {
                              // In real app, use url_launcher
                            },
                          ),
                        ],
                      ),
                    ],
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