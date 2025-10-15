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
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: const Text('New Contact'),
            trailing: GestureDetector(
              onTap: () {
                if (nameController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty) {
                  model.addContact(Contact(
                    name: nameController.text,
                    email: emailController.text,
                    phoneNumber: phoneController.text,
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
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CupertinoTextField(
                  controller: nameController,
                  placeholder: 'Full Name',
                  padding: const EdgeInsets.all(12),
                ),
                const SizedBox(height: 12),
                CupertinoTextField(
                  controller: emailController,
                  placeholder: 'Email',
                  padding: const EdgeInsets.all(12),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),
                CupertinoTextField(
                  controller: phoneController,
                  placeholder: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  padding: const EdgeInsets.all(12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
