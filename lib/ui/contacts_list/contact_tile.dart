import 'package:alison/ui/contacts_list/contact_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:alison/ui/model/contacts_model.dart';
import 'package:alison/data/contact.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final int index;

  const ContactTile({super.key, required this.contact, required this.index});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: CupertinoColors.systemGrey5,
                width: 0.5,
              ),
            ),
          ),
          child: CupertinoListTile(
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
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: contact.isFavorite
                ? Row(
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        size: 14,
                        color: CupertinoColors.systemYellow,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'favorite',
                        style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  )
                : null,
            trailing: contact.isFavorite
                ? Icon(
                    CupertinoIcons.star_fill,
                    size: 16,
                    color: CupertinoColors.systemYellow,
                  )
                : null,
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => ContactDetailPage(contact: contact),
                ),
              );
            },
          ),
        );
      },
    );
  }
}