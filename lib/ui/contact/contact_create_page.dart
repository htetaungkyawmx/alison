import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('New Contact'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(
            'Done',
            style: TextStyle(
              color: CupertinoColors.systemBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: _saveContact,
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            // Photo Section
            Container(
              color: CupertinoColors.systemBackground,
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _showImagePicker,
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CupertinoColors.systemGrey5,
                            image: _selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(_selectedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _selectedImage == null
                              ? const Icon(
                                  CupertinoIcons.person,
                                  size: 40,
                                  color: CupertinoColors.systemGrey2,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: CupertinoColors.systemBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              CupertinoIcons.camera,
                              size: 16,
                              color: CupertinoColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _showImagePicker,
                    child: Text(
                      'Add Photo',
                      style: TextStyle(
                        color: CupertinoColors.systemBlue,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 1),

            // Form Fields
            CupertinoListSection.insetGrouped(
              margin: EdgeInsets.zero,
              children: [
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.person),
                  title: CupertinoTextField(
                    controller: nameController,
                    placeholder: 'First Name',
                    padding: EdgeInsets.zero,
                    style: const TextStyle(fontSize: 16),
                    decoration: null,
                  ),
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.phone),
                  title: CupertinoTextField(
                    controller: phoneController,
                    placeholder: 'Phone',
                    keyboardType: TextInputType.phone,
                    padding: EdgeInsets.zero,
                    style: const TextStyle(fontSize: 16),
                    decoration: null,
                  ),
                ),
                CupertinoListTile(
                  leading: const Icon(CupertinoIcons.mail),
                  title: CupertinoTextField(
                    controller: emailController,
                    placeholder: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    padding: EdgeInsets.zero,
                    style: const TextStyle(fontSize: 16),
                    decoration: null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Choose Photo'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: const Text('Take Photo'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
            child: const Text('Choose from Library'),
          ),
          if (_selectedImage != null)
            CupertinoActionSheetAction(
              onPressed: () {
                setState(() {
                  _selectedImage = null;
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Remove Photo',
                style: TextStyle(color: CupertinoColors.systemRed),
              ),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      _showError('Failed to pick image: $e');
    }
  }

  void _saveContact() {
    if (nameController.text.isEmpty) {
      _showError('Please enter a name');
      return;
    }

    final model = ScopedModel.of<ContactsModel>(context);
    model.addContact(Contact(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phoneNumber: phoneController.text.trim(),
    ));

    Navigator.pop(context);
  }

  void _showError(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}