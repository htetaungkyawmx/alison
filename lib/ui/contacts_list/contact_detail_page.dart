import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/contact.dart';

class ContactDetailPage extends StatelessWidget {
  final Contact contact;
  const ContactDetailPage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(contact.name),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: [
            GestureDetector(
              onTap: () {
                if (contact.image != null || contact.imageUrl != null) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => FullPhotoPage(contact: contact),
                    ),
                  );
                }
              },
              child: Center(
                child: Hero(
                  tag: contact.name,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: CupertinoColors.systemGrey5,
                    backgroundImage: contact.image != null
                        ? MemoryImage(contact.image!)
                        : (contact.imageUrl != null
                        ? NetworkImage(contact.imageUrl!)
                        : null),
                    child: (contact.image == null && contact.imageUrl == null)
                        ? Text(
                      contact.name[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                contact.name,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.phone),
                  title: Text(contact.phoneNumber),
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.mail),
                  title: Text(contact.email),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FullPhotoPage extends StatelessWidget {
  final Contact contact;
  const FullPhotoPage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      child: Center(
        child: Hero(
          tag: contact.name,
          child: contact.image != null
              ? Image.memory(contact.image!)
              : (contact.imageUrl != null
              ? Image.network(contact.imageUrl!)
              : Container()),
        ),
      ),
    );
  }
}
