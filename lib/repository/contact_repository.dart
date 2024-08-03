import 'dart:async';
import 'dart:collection';

import 'package:contact_list_app/contact.dart';

class ContactRepository {
  final _contacts = HashSet<Contact>.identity();
  final _contactsController = StreamController<Set<Contact>>.broadcast();

  Set<Contact> get contacts => UnmodifiableSetView(_contacts);

  void addContact(Contact contact) {
    _contacts.add(contact);
    _contactsController.sink.add(_contacts);
  }

  void updateContact(Contact contact) {
    if (_contacts.contains(contact)) {
      _contacts.remove(contact);
      _contacts.add(contact);
      _contactsController.sink.add(_contacts);
    }
  }

  void removeContact(Contact contact) {
    _contacts.remove(contact);
    _contactsController.sink.add(_contacts);
  }

  Stream<Set<Contact>> get contactsStream => _contactsController.stream;

  void dispose() {
    _contactsController.close();
  }

  Future<Contact> createContact({
    required String name,
    required String imagePath,
  }) async {
    final contact = Contact()
      ..name = name
      ..imagePath = imagePath;

    addContact(contact);
    return contact;
  }
}
