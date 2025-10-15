import 'package:alison/ui/contacts_list/contact_detail_page.dart';
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
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CupertinoButton(
            padding: const EdgeInsets.all(16),
            borderRadius: BorderRadius.circular(16),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => ContactDetailPage(contact: contact),
                ),
              );
            },
            child: Row(
              children: [
                // Contact Avatar with Image
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        CupertinoColors.systemBlue,
                        CupertinoColors.systemPurple,
                      ],
                    ),
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
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: CupertinoColors.white,
                            ),
                          ),
                        )
                      : null,
                ),
                
                const SizedBox(width: 16),
                
                // Contact Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              contact.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: CupertinoColors.label,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (contact.isFavorite)
                            const Icon(
                              CupertinoIcons.star_fill,
                              color: CupertinoColors.systemYellow,
                              size: 16,
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        contact.phoneNumber,
                        style: TextStyle(
                          fontSize: 15,
                          color: CupertinoColors.systemGrey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        contact.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemGrey2,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Favorite Button
                GestureDetector(
                  onTap: () => model.toggleFavorite(index),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CupertinoColors.systemGrey6,
                    ),
                    child: Icon(
                      contact.isFavorite
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: contact.isFavorite
                          ? CupertinoColors.systemRed
                          : CupertinoColors.systemGrey2,
                      size: 20,
                    ),
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