import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:alison/data/contact.dart';
import 'package:alison/ui/model/contacts_model.dart';

class ContactCreatePage extends StatefulWidget {
  const ContactCreatePage({super.key});

  @override
  State<ContactCreatePage> createState() => _ContactCreatePageState();
}

class _ContactCreatePageState extends State<ContactCreatePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: const Text('New Contact'),
            trailing: GestureDetector(
              onTap: () {
                if (_nameController.text.isNotEmpty &&
                    _phoneController.text.isNotEmpty) {
                  model.addContact(Contact(
                    name: _nameController.text,
                    email: _emailController.text,
                    phoneNumber: _phoneController.text,
                  ));
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Save',
                style: TextStyle(color: CupertinoColors.activeBlue),
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CupertinoTextField(
                    controller: _nameController,
                    placeholder: 'Name',
                    padding: const EdgeInsets.all(12),
                  ),
                  const SizedBox(height: 15),
                  CupertinoTextField(
                    controller: _emailController,
                    placeholder: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    padding: const EdgeInsets.all(12),
                  ),
                  const SizedBox(height: 15),
                  CupertinoTextField(
                    controller: _phoneController,
                    placeholder: 'Phone Number',
                    keyboardType: TextInputType.phone,
                    padding: const EdgeInsets.all(12),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
