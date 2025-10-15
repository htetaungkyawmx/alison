import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:alison/ui/model/contacts_model.dart';
import 'package:alison/ui/contacts_list/contacts_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ContactsModel contactsModel = ContactsModel();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactsModel>(
      model: contactsModel,
      child: const CupertinoApp(
        debugShowCheckedModeBanner: false,
        home: ContactsListPage(),
      ),
    );
  }
}
