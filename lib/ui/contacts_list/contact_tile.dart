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
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: CupertinoListTile(
              leading: Hero(
                tag: contact.name,
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: CupertinoColors.systemGrey5,
                  backgroundImage:
                  contact.image != null ? MemoryImage(contact.image!) : null,
                  child: contact.image == null
                      ? Text(
                    contact.name[0],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.black,
                    ),
                  )
                      : null,
                ),
              ),
              title: Text(contact.name),
              subtitle: Text(contact.phoneNumber),
              trailing: GestureDetector(
                onTap: () => model.toggleFavorite(index),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) => ScaleTransition(
                    scale: anim,
                    child: child,
                  ),
                  child: Icon(
                    contact.isFavorite
                        ? CupertinoIcons.star_fill
                        : CupertinoIcons.star,
                    key: ValueKey(contact.isFavorite),
                    color: contact.isFavorite
                        ? CupertinoColors.systemYellow
                        : CupertinoColors.systemGrey2,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
