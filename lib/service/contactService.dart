import 'dart:async';
import 'package:contents_buddy_app/db_helper/repository.dart';
import 'package:contents_buddy_app/model/contact.dart';


class ContactService
{
  late Repository _repository;
  ContactService(){
    _repository = Repository();
  }
  //Save Contact
  SaveContact(Contact contact) async{
    return await _repository.insertData('contacts', contact.contactMap());
  }
  //Read All Contacts
  readAllContacts() async{
    return await _repository.readData('contacts');
  }
  //Update Contact
  UpdateContact(Contact contact) async{
    return await _repository.updateData('contacts', contact.contactMap());
  }

  deleteContact(contactId) async {
    return await _repository.deleteDataById('contacts', contactId);
  }

}
