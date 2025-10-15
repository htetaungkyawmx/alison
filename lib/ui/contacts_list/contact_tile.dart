import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alison/data/contact.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:alison/ui/model/contacts_model.dart';
import 'package:alison/ui/contacts_list/widget/contact_detail_page.dart';

class ContactTile extends StatelessWidget {
  final int index;
  const ContactTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        final Contact contact = model.contacts[index];
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: CupertinoColors.systemGrey5,
                  backgroundImage:
                      contact.imagePath != null ? AssetImage(contact.imagePath!) : null,
                  child: contact.imagePath == null
                      ? Text(
                          contact.name[0],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.black,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(contact.name,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                      Text(contact.phoneNumber,
                          style: const TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.systemGrey)),
                    ],
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
                        : CupertinoColors.systemGrey3,
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
