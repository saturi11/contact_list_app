import 'dart:io';

import 'package:contact_list_app/repository/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateContactScreen extends StatefulWidget {
  @override
  _CreateContactScreenState createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  final _nameController = TextEditingController();
  String? _imagePath;

  final _repository = ContactRepository();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _saveContact() async {
    final name = _nameController.text;
    if (_imagePath != null) {
      await _repository.createContact(name: name, imagePath: _imagePath!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),
            if (_imagePath != null)
              Image.file(
                File(_imagePath!),
                height: 200.0,
              )
            else
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200.0,
                  child: Center(
                    child: Icon(Icons.add_a_photo, size: 48.0),
                  ),
                ),
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveContact,
              child: Text('Save Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
