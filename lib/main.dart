import 'package:contents_buddy_app/model/contact.dart';
import 'package:contents_buddy_app/screens/saveContact.dart';
import 'package:contents_buddy_app/screens/updateContact.dart';
import 'package:contents_buddy_app/screens/viewContact.dart';
import 'package:contents_buddy_app/service/contactService.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CONTENTS BUDDY',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Contact> _contactList = <Contact>[];
  final _contactService = ContactService();

  getAllContactDetails() async {
    var contacts = await _contactService.readAllContacts();
    _contactList = <Contact>[];
    contacts.forEach((contact) {
      setState(() {
        var contactModel = Contact();
        contactModel.id = contact['id'];
        contactModel.name = contact['name'];
        contactModel.phoneNumber = contact['phoneNumber'];
        contactModel.email = contact['email'];
        _contactList.add(contactModel);
      });
    });
  }

  @override
  void initState() {
    getAllContactDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, contactId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure Do You Want To Delete?',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result = await _contactService.deleteContact(contactId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllContactDetails();
                      _showSuccessSnackBar(
                          'Contact Detail Deleted Successfully');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.cyan),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  // Search Contact List
  void _searchSavedContacts(String value) {
    setState(() {
      _contactList = _contactList
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CONTENTS BUDDY"),
      ),
      body: Container(
        //padding: EdgeInsets.all(5.0),
        child: Column(children: [
          TextFormField(
            autofocus: false,
            onChanged: (value) => _searchSavedContacts(value),
            decoration: const InputDecoration(
              border: InputBorder.none,
              labelText: 'Search Contacts Here',
              hintText: 'Search Your Contact',
              hintStyle: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
              itemCount: _contactList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewContact(
                                contact: _contactList[index],
                              )));
                    },
                    leading: const Icon(Icons.person),
                    title: Text(_contactList[index].name ?? ''),
                    subtitle: Text(_contactList[index].phoneNumber ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateContact(
                                        contact: _contactList[index],
                                      ))).then((data) {
                                if (data != null) {
                                  getAllContactDetails();
                                  _showSuccessSnackBar(
                                      'Contact Detail Updated Successfully');
                                }
                              });
                              ;
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.green,
                            )),
                        IconButton(
                            onPressed: () {
                              _deleteFormDialog(context, _contactList[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                );
              }),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SaveContact()))
              .then((data) {
            if (data != null) {
              getAllContactDetails();
              _showSuccessSnackBar('Contact Detail Saved Successfully');
            }
          });
        },
        child: const Icon(Icons.contacts),
      ),
    );
  }
}
