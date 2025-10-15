import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:alison/ui/model/contacts_model.dart';
import 'package:alison/data/contact.dart';

class ContactTile extends StatelessWidget {
  final int index;

  const ContactTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        final Contact contact = model.contacts[index];
        return CupertinoListTile(
          leadingSize: 50,
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: CupertinoColors.systemGrey5,
            child: Text(
              contact.name[0],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.black,
              ),
            ),
          ),
          title: Text(
            contact.name,
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            contact.phoneNumber,
            style: const TextStyle(color: CupertinoColors.systemGrey),
          ),
          trailing: GestureDetector(
            onTap: () => model.toggleFavorite(index),
            child: Icon(
              contact.isFavorite
                  ? CupertinoIcons.star_fill
                  : CupertinoIcons.star,
              color: contact.isFavorite
                  ? CupertinoColors.systemYellow
                  : CupertinoColors.systemGrey,
            ),
          ),
        );
      },
    );
  }
}
