import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../data/contact.dart';
import '../model/contacts_model.dart';
import 'contact_detail_page.dart';

class ContactTile extends StatelessWidget {
  final int index;
  const ContactTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        final contact = model.contacts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => ContactDetailPage(contact: contact),
              ),
            );
          },
          child: Container(
            color: CupertinoColors.systemBackground,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Hero(
                  tag: contact.name,
                  child: CircleAvatar(
                    radius: 22,
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
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: CupertinoColors.black,
                      ),
                    )
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    contact.name,
                    style: const TextStyle(
                      fontSize: 17,
                      color: CupertinoColors.label,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => model.toggleFavorite(index),
                  child: Icon(
                    contact.isFavorite
                        ? CupertinoIcons.star_fill
                        : CupertinoIcons.star,
                    color: contact.isFavorite
                        ? CupertinoColors.systemYellow
                        : CupertinoColors.systemGrey2,
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
