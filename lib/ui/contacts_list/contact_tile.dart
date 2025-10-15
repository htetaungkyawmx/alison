import 'package:alison/ui/contacts_list/contact_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../data/contact.dart';
import '../model/contacts_model.dart';

class ContactTile extends StatelessWidget {
  final int index;
  const ContactTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        final Contact contact = model.contacts[index];
        return CupertinoListTile(
          leading: CircleAvatar(
            radius: 22,
            backgroundColor: CupertinoColors.systemGrey5,
            backgroundImage:
                contact.image != null ? MemoryImage(contact.image!) : null,
            child: contact.image == null
                ? Text(
                    contact.name[0],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black),
                  )
                : null,
          ),
          title: Text(contact.name),
          subtitle: Text(contact.phoneNumber),
          trailing: GestureDetector(
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
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => ContactDetailPage(contact: contact),
              ),
            );
          },
        );
      },
    );
  }
}
