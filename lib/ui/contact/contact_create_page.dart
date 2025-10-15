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
  bool isFavorite = false;

  final List<String> samplePhotos = [
    'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=200&h=200&fit=crop&crop=face',
    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200&h=200&fit=crop&crop=face',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=200&h=200&fit=crop&crop=face',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&h=200&fit=crop&crop=face',
    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&h=200&fit=crop&crop=face',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&h=200&fit=crop&crop=face',
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          'New Contact',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text(
            'Cancel',
            style: TextStyle(color: CupertinoColors.systemRed),
          ),
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
          onPressed: _saveContact,
        ),
      ),
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(0),
          children: [
            // Photo Section
            Container(
              color: CupertinoColors.systemBackground,
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _showPhotoOptions,
                    child: Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: selectedPhotoUrl == null
                                ? LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      CupertinoColors.systemBlue,
                                      CupertinoColors.systemPurple,
                                    ],
                                  )
                                : null,
                            image: selectedPhotoUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(selectedPhotoUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: selectedPhotoUrl == null
                              ? const Icon(
                                  CupertinoIcons.photo,
                                  size: 40,
                                  color: CupertinoColors.white,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemBlue,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: CupertinoColors.systemBackground,
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              CupertinoIcons.camera,
                              size: 18,
                              color: CupertinoColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _showPhotoOptions,
                    child: Text(
                      'Choose Photo',
                      style: TextStyle(
                        color: CupertinoColors.systemBlue,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Form Section
            CupertinoListSection.insetGrouped(
              margin: EdgeInsets.zero,
              children: [
                // Name
                CupertinoListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      CupertinoIcons.person,
                      size: 18,
                      color: CupertinoColors.systemBlue,
                    ),
                  ),
                  title: CupertinoTextField(
                    controller: nameController,
                    placeholder: 'Full Name',
                    padding: EdgeInsets.zero,
                    style: const TextStyle(fontSize: 16),
                    decoration: null,
                  ),
                ),

                // Phone
                CupertinoListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGreen.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      CupertinoIcons.phone,
                      size: 18,
                      color: CupertinoColors.systemGreen,
                    ),
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

                // Email
                CupertinoListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemOrange.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      CupertinoIcons.mail,
                      size: 18,
                      color: CupertinoColors.systemOrange,
                    ),
                  ),
                  title: CupertinoTextField(
                    controller: emailController,
                    placeholder: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                    padding: EdgeInsets.zero,
                    style: const TextStyle(fontSize: 16),
                    decoration: null,
                  ),
                ),

                // Favorite Toggle
                CupertinoListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemRed.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      CupertinoIcons.heart,
                      size: 18,
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                  title: const Text('Add to Favorites'),
                  trailing: CupertinoSwitch(
                    value: isFavorite,
                    onChanged: (value) => setState(() => isFavorite = value),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPhotoOptions() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Choose a Photo'),
        message: const Text('Select a profile picture for this contact'),
        actions: [
          // Photo Grid
          Container(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: samplePhotos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPhotoUrl = samplePhotos[index];
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(samplePhotos[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                selectedPhotoUrl = null;
              });
              Navigator.pop(context);
            },
            child: const Text('Remove Photo'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: CupertinoColors.systemRed),
          ),
        ),
      ),
    );
  }

  void _saveContact() {
    if (nameController.text.isEmpty || phoneController.text.isEmpty) {
      _showAlert('Missing Information', 
          'Please enter at least name and phone number.');
      return;
    }

    final model = ScopedModel.of<ContactsModel>(context);
    model.addContact(Contact(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      isFavorite: isFavorite,
      photoUrl: selectedPhotoUrl,
    ));

    Navigator.pop(context);
  }

  void _showAlert(String title, String content) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
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