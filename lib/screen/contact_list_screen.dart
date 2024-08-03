import 'package:contact_list_app/contact.dart';
import 'package:contact_list_app/repository/contact_repository.dart';
import 'package:contact_list_app/screen/create_contact_screen.dart';
import 'package:flutter/material.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final _repository = ContactRepository();
  Set<Contact> _contacts = {};

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final contacts = await _repository.contacts;
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts.elementAt(index);
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(contact.imagePath),
            ),
            title: Text(contact.name),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreateContact,
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToCreateContact() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateContactScreen()),
    );
  }
}
