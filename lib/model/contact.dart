// Model Class
class Contact {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;

  contactMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['phoneNumber'] = phoneNumber!;
    mapping['email'] = email!;
    return mapping;
  }
}

