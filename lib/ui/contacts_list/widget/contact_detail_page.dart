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
          children: [
            const SizedBox(height: 30),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: CupertinoColors.systemGrey5,
                child: Text(
                  contact.name[0],
                  style: const TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                  onTap: () {
                    // in real app, use url_launcher
                  },
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
