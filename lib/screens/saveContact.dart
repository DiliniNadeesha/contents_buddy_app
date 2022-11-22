import 'dart:io';

import 'package:contents_buddy_app/model/contact.dart';
import 'package:contents_buddy_app/service/contactService.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

// Create the widget, SaveContact by inheriting StatefulWidget
class SaveContact extends StatefulWidget {
  const SaveContact({Key? key}) : super(key: key);

  // Override the createState of StatefulWidget method to create the state, _SaveContactState
  @override
  State<SaveContact> createState() => _SaveContactState();
}

class _SaveContactState extends State<SaveContact> {
  var _contactNameController = TextEditingController();
  var _contactPhoneNumberController = TextEditingController();
  var _contactEmailController = TextEditingController();
  bool _validateName = false;
  bool _validatePhoneNumber = false;
  bool _validateEmail = false;
  var _contactService=ContactService();

  // bool isUploadImage = false;
  // var selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CONTENTS BUDDY"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Contact',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // children: [
                  //   CircleAvatar(
                  //     backgroundImage: isUploadImage && selectedImage != null ? FileImage(File(selectedImage)) : AssetImage('images/eliyana.jpg') as ImageProvider,
                  //   ),
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/eliyana.jpg'),
                    ),
                    SizedBox(
                      height: 20.0,
                      width: 150.0,
                      child: Divider(
                        color: Colors.teal.shade100,
                      ),
                    ),
                    TextField(
                        controller: _contactNameController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Name',
                          labelText: 'Enter Name',
                          icon: const Icon(Icons.person),
                          errorText: _validateName ? 'Name Value Can\'t Be Empty' : null,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                        controller: _contactPhoneNumberController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'PhoneNumber',
                          labelText: 'Enter PhoneNumber',
                          icon: const Icon(Icons.phone),
                          errorText: _validatePhoneNumber ? 'Phone Number Value Can\'t Be Empty' : null,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                        controller: _contactEmailController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Email',
                          labelText: 'Enter Email',
                          icon: const Icon(Icons.email),
                          errorText: _validateEmail ? 'Email Value Can\'t Be Empty' : null,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.cyan,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _contactNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _contactPhoneNumberController.text.isEmpty
                              ? _validatePhoneNumber = true
                              : _validatePhoneNumber = false;
                          _contactEmailController.text.isEmpty
                              ? _validateEmail = true
                              : _validateEmail = false;

                        });
                        if (_validateName == false &&
                            _validatePhoneNumber == false &&
                            _validateEmail == false) {
                          var _contact = Contact();
                          _contact.name = _contactNameController.text;
                          _contact.phoneNumber = _contactPhoneNumberController.text;
                          _contact.email = _contactEmailController.text;
                          var result=await _contactService.SaveContact(_contact);
                          Navigator.pop(context,result);
                        }
                      },
                      child: const Text('Save Contact Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _contactNameController.text = '';
                        _contactPhoneNumberController.text = '';
                        _contactEmailController.text = '';
                      },
                      child: const Text('Clear Details')
                  )
                ],
              )
            ],
          ),
        ),
     ],
      ),
    ),
    ),
    );
  }
}


