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
          backgroundColor: CupertinoColors.systemGroupedBackground,
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
                'Done',
                style: TextStyle(
                    color: CupertinoColors.activeBlue,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: CupertinoColors.systemGrey5,
                      backgroundImage:
                      _imageBytes != null ? MemoryImage(_imageBytes!) : null,
                      child: _imageBytes == null
                          ? const Icon(
                        CupertinoIcons.person_crop_circle_badge_plus,
                        size: 34,
                        color: CupertinoColors.systemGrey2,
                      )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CupertinoListSection.insetGrouped(
                  backgroundColor: CupertinoColors.systemBackground,
                  hasLeading: false,
                  children: [
                    _buildTextField(nameController, 'Full Name', CupertinoIcons.person),
                    _buildTextField(phoneController, 'Phone', CupertinoIcons.phone),
                    _buildTextField(emailController, 'Email', CupertinoIcons.mail),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String placeholder, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: CupertinoTextField(
        controller: controller,
        placeholder: placeholder,
        prefix: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Icon(icon, color: CupertinoColors.systemGrey),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        keyboardType: placeholder == 'Phone'
            ? TextInputType.phone
            : TextInputType.text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
