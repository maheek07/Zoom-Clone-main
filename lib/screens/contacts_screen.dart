// ignore_for_file: use_build_context_synchronously

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:zoom_meet/utils/colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zoom_meet/utils/utils.dart';

class ContactSCreen extends StatefulWidget {
  const ContactSCreen({super.key});

  @override
  State<ContactSCreen> createState() => _ContactSCreenState();
}

class _ContactSCreenState extends State<ContactSCreen> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  Future<void> _getContacts() async {
    if (await Permission.contacts.request().isGranted) {
      Iterable<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts.toList();
      });
    } else {
      showSnackBar(context, 'Allow Permission for Contact Access');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: ((context, index) {
          return ListTile(
            title: Text(_contacts[index].displayName!),
            subtitle: Text(_contacts[index].phones!.first.value!),
            leading: CircleAvatar(
              backgroundImage: MemoryImage(_contacts[index].avatar!),
            ),
          );
        }),
      ),
    );
  }
}
