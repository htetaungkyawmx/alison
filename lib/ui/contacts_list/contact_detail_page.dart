import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/contact.dart';

class ContactDetailPage extends StatelessWidget {
  final Contact contact;
  const ContactDetailPage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(contact.name),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Hero(
                tag: contact.name,
                child: CircleAvatar(
                  radius: 65,
                  backgroundColor: CupertinoColors.systemGrey5,
                  backgroundImage:
                  contact.image != null ? MemoryImage(contact.image!) : null,
                  child: contact.image == null
                      ? Text(
                    contact.name[0],
                    style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),
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
