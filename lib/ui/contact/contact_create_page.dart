import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/contact.dart';
import '../model/contacts_model.dart';

class ContactCreatePage extends StatefulWidget {
  const ContactCreatePage({super.key});

  @override
  State<ContactCreatePage> createState() => _ContactCreatePageState();
}

class _ContactCreatePageState extends State<ContactCreatePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() => _imageBytes = bytes);
    }
  }

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
                    image: _imageBytes,
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
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: CupertinoColors.systemGrey5,
                        backgroundImage:
                        _imageBytes != null ? MemoryImage(_imageBytes!) : null,
                        child: _imageBytes == null
                            ? const Icon(CupertinoIcons.person_add,
                            size: 35, color: CupertinoColors.systemGrey)
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
