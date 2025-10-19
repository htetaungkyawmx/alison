import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../data/contact.dart';

class ContactDetailPage extends StatelessWidget {
  final Contact contact;
  const ContactDetailPage({super.key, required this.contact});

  void _showFullImage(BuildContext context) {
    if (contact.image == null) return;
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoPageScaffold(
        backgroundColor: Colors.black,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: Hero(
              tag: contact.name,
              child: Image.memory(
                contact.image!,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(contact.name),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            Center(
              child: GestureDetector(
                onTap: () => _showFullImage(context),
                child: Hero(
                  tag: contact.name,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: CupertinoColors.systemGrey5,
                    backgroundImage: contact.image != null
                        ? MemoryImage(contact.image!)
                        : null,
                    child: contact.image == null
                        ? Text(
                      contact.name[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                contact.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 25),
            CupertinoListSection.insetGrouped(
              backgroundColor: CupertinoColors.systemBackground,
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
