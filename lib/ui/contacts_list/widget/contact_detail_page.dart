import 'package:flutter/cupertino.dart';
import 'package:alison/data/contact.dart';
import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 30),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: CupertinoColors.systemGrey5,
                backgroundImage:
                    contact.imagePath != null ? AssetImage(contact.imagePath!) : null,
                child: contact.imagePath == null
                    ? Text(
                        contact.name[0],
                        style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                contact.name,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 25),
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
