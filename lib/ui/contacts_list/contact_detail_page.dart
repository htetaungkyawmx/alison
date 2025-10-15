import 'package:flutter/cupertino.dart';
import 'package:alison/data/contact.dart';
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
            middle: Text(updatedContact.name),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => model.toggleFavorite(contactIndex),
              child: Icon(
                updatedContact.isFavorite
                    ? CupertinoIcons.star_fill
                    : CupertinoIcons.star,
                color: updatedContact.isFavorite
                    ? CupertinoColors.systemYellow
                    : CupertinoColors.systemGrey,
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
                        width: 100,
                        height: 100,
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
                                  updatedContact.name[0],
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        updatedContact.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Contact Info
                      CupertinoListSection.insetGrouped(
                        children: [
                          CupertinoListTile(
                            leading: const Icon(CupertinoIcons.phone),
                            title: const Text('Phone'),
                            subtitle: Text(updatedContact.phoneNumber),
                            onTap: () {
                              // Implement phone call
                            },
                          ),
                          CupertinoListTile(
                            leading: const Icon(CupertinoIcons.mail),
                            title: const Text('Email'),
                            subtitle: Text(updatedContact.email),
                            onTap: () {
                              // Implement email
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