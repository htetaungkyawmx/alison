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
  String? selectedPhotoUrl;

  final List<String> samplePhotos = [
    'https://i.pravatar.cc/150?img=1',
    'https://i.pravatar.cc/150?img=2',
    'https://i.pravatar.cc/150?img=3',
    'https://i.pravatar.cc/150?img=4',
    'https://i.pravatar.cc/150?img=5',
    'https://i.pravatar.cc/150?img=6',
  ];

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
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
                'Save',
                style: TextStyle(
                  color: CupertinoColors.systemBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty) {
                  model.addContact(Contact(
                    name: nameController.text,
                    email: emailController.text,
                    phoneNumber: phoneController.text,
                    photoUrl: selectedPhotoUrl,
                  ));
                  Navigator.pop(context);
                } else {
                  _showAlert(context);
                }
              },
            ),
          ),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                // Photo Selection
                Container(
                  color: CupertinoColors.systemBackground,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _showPhotoOptions,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CupertinoColors.systemGrey5,
                            image: selectedPhotoUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(selectedPhotoUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: selectedPhotoUrl == null
                              ? const Icon(
                                  CupertinoIcons.camera,
                                  size: 35,
                                  color: CupertinoColors.systemGrey2,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _showPhotoOptions,
                        child: Text(
                          'Add Photo',
                          style: TextStyle(
                            color: CupertinoColors.systemBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 1),

                // Form Fields
                CupertinoListSection.insetGrouped(
                  additionalDividerMargin: 0,
                  children: [
                    CupertinoListTile(
                      leading: const Icon(
                        CupertinoIcons.person,
                        color: CupertinoColors.systemGrey,
                      ),
                      title: CupertinoTextField(
                        controller: nameController,
                        placeholder: 'Full Name',
                        padding: EdgeInsets.zero,
                        style: const TextStyle(fontSize: 16),
                        decoration: null,
                      ),
                    ),
                    CupertinoListTile(
                      leading: const Icon(
                        CupertinoIcons.phone,
                        color: CupertinoColors.systemGrey,
                      ),
                      title: CupertinoTextField(
                        controller: phoneController,
                        placeholder: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        padding: EdgeInsets.zero,
                        style: const TextStyle(fontSize: 16),
                        decoration: null,
                      ),
                    ),
                    CupertinoListTile(
                      leading: const Icon(
                        CupertinoIcons.mail,
                        color: CupertinoColors.systemGrey,
                      ),
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
      },
    );
  }

  void _showPhotoOptions() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          ...samplePhotos.map((photoUrl) => CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    selectedPhotoUrl = photoUrl;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(photoUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text('Select this photo'),
                    ],
                  ),
                ),
              )),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Missing Information'),
        content: const Text('Please enter at least name and phone number.'),
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