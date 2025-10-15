import 'package:alison/ui/contacts_list/widget/contact_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:alison/ui/model/contacts_model.dart';
import 'package:alison/data/contact.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactTile extends StatelessWidget {
  final int index;

  const ContactTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        final Contact contact = model.contacts[index];
        return Container(
          color: CupertinoColors.systemBackground,
          child: Column(
            children: [
              const Divider(height: 1, color: CupertinoColors.systemGrey5),
              CupertinoListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CupertinoColors.systemGrey5,
                    image: contact.photoUrl != null
                        ? DecorationImage(
                            image: NetworkImage(contact.photoUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: contact.photoUrl == null
                      ? Center(
                          child: Text(
                            contact.name[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        )
                      : null,
                ),
                leadingSize: 40,
                title: Text(
                  contact.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  contact.phoneNumber,
                  style: const TextStyle(
                    fontSize: 15,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () => model.toggleFavorite(index),
                  child: Icon(
                    contact.isFavorite
                        ? CupertinoIcons.star_fill
                        : CupertinoIcons.star,
                    color: contact.isFavorite
                        ? CupertinoColors.systemYellow
                        : CupertinoColors.systemGrey3,
                    size: 22,
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
              ),
            ],
          ),
        );
      },
    );
  }
}