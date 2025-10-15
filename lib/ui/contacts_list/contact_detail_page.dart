import 'package:flutter/cupertino.dart';
import 'package:alison/data/contact.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:alison/ui/model/contacts_model.dart';

class ContactDetailPage extends StatelessWidget {
  final Contact contact;
  const ContactDetailPage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactsModel>(
      builder: (context, child, model) {
        final contactIndex = model.contacts.indexOf(contact);
        final updatedContact = model.contacts[contactIndex];
        
        return CupertinoPageScaffold(
          backgroundColor: CupertinoColors.systemGroupedBackground,
          navigationBar: CupertinoNavigationBar(
            middle: Text(
              'Contact',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: CupertinoColors.label,
              ),
            ),
            trailing: GestureDetector(
              onTap: () => model.toggleFavorite(contactIndex),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: CupertinoColors.systemGrey6,
                ),
                child: Icon(
                  updatedContact.isFavorite
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart,
                  color: updatedContact.isFavorite
                      ? CupertinoColors.systemRed
                      : CupertinoColors.systemGrey,
                  size: 22,
                ),
              ),
            ),
          ),
          child: SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      // Profile Photo
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: updatedContact.photoUrl == null
                              ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    CupertinoColors.systemBlue,
                                    CupertinoColors.systemPurple,
                                  ],
                                )
                              : null,
                          image: updatedContact.photoUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(updatedContact.photoUrl!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: CupertinoColors.systemGrey.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: updatedContact.photoUrl == null
                            ? Center(
                                child: Text(
                                  updatedContact.name[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w700,
                                    color: CupertinoColors.white,
                                  ),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(height: 24),
                      // Name and Favorite Badge
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Text(
                              updatedContact.name,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: CupertinoColors.label,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            if (updatedContact.isFavorite)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 6),
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemRed.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      CupertinoIcons.heart_fill,
                                      color: CupertinoColors.systemRed,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Favorite Contact',
                                      style: TextStyle(
                                        color: CupertinoColors.systemRed,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                // Contact Information
                SliverList(
                  delegate: SliverChildListDelegate([
                    CupertinoListSection.insetGrouped(
                      header: const Text(
                        'CONTACT INFORMATION',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.systemGrey,
                          letterSpacing: -0.1,
                        ),
                      ),
                      children: [
                        _buildContactTile(
                          icon: CupertinoIcons.phone_fill,
                          iconColor: CupertinoColors.systemGreen,
                          title: 'Phone',
                          subtitle: updatedContact.phoneNumber,
                          onTap: () => _makeCall(updatedContact.phoneNumber),
                        ),
                        _buildContactTile(
                          icon: CupertinoIcons.mail_solid,
                          iconColor: CupertinoColors.systemBlue,
                          title: 'Email',
                          subtitle: updatedContact.email,
                          onTap: () => _sendEmail(updatedContact.email),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return CupertinoListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: iconColor),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: CupertinoColors.systemGrey,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: CupertinoColors.label,
        ),
      ),
      trailing: const Icon(
        CupertinoIcons.chevron_forward,
        size: 18,
        color: CupertinoColors.systemGrey3,
      ),
      onTap: onTap,
    );
  }

  void _makeCall(String phoneNumber) {
    // Implement phone call functionality
    print('Calling $phoneNumber');
  }

  void _sendEmail(String email) {
    // Implement email functionality
    print('Sending email to $email');
  }
}