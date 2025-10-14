import 'package:alison/data/contact.dart';
import 'package:alison/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactTile extends StatelessWidget {
  final int contactIndex;
  final VoidCallback onFavoriteToggle;

  const ContactTile({
    Key? key,
    required this.contactIndex,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {

      } 
      title: Text(contact.name),
      subtitle: Text(contact.email),
      trailing: IconButton(
        icon: Icon(
          contact.isFavorite ? Icons.star : Icons.star_border,
        ),
        color: contact.isFavorite ? Colors.amber : Colors.grey,
        onPressed: onFavoriteToggle,
      ),
    );
  }
}
