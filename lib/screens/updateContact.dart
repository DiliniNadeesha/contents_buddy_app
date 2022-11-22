import 'package:contents_buddy_app/model/contact.dart';
import 'package:contents_buddy_app/service/contactService.dart';
import 'package:flutter/material.dart';

class UpdateContact extends StatefulWidget {
  final Contact contact;
  const UpdateContact({Key? key,required this.contact}) : super(key: key);

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  var _contactNameController = TextEditingController();
  var _contactPhoneNumberController = TextEditingController();
  var _contactEmailController = TextEditingController();
  bool _validateName = false;
  bool _validatePhoneNumber = false;
  bool _validateEmail = false;
  var _contactService=ContactService();

  @override
  void initState() {
    setState(() {
      _contactNameController.text=widget.contact.name??'';
      _contactPhoneNumberController.text=widget.contact.phoneNumber??'';
      _contactEmailController.text=widget.contact.email??'';
    });
    super.initState();
  }
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
                'Update New Contact',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _contactNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText: _validateName ? 'Name Value Can\'t Be Empty' : null,
                    icon: const Icon(Icons.person),
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _contactPhoneNumberController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter PhoneNumber',
                    labelText: 'PhoneNumber',
                    errorText: _validatePhoneNumber ? 'PhoneNumber Value Can\'t Be Empty' : null,
                    icon: const Icon(Icons.phone),
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _contactEmailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Email',
                    labelText: 'Email',
                    errorText: _validateEmail ? 'Email Value Can\'t Be Empty' : null,
                    icon: const Icon(Icons.email),
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.green,
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
                          _contact.id=widget.contact.id;
                          _contact.name = _contactNameController.text;
                          _contact.phoneNumber = _contactPhoneNumberController.text;
                          _contact.email = _contactEmailController.text;
                          var result=await _contactService.UpdateContact(_contact);
                          Navigator.pop(context,result);
                        }
                      },
                      child: const Text('Update Details')),
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
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

