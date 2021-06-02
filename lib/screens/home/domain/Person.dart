class Person {
  int id;
  String first;
  String last;
  String? email;
  String? contact;

  static final columns = ["id", "first", "last", "email", "contact"];

  Person(
      {this.id = 0,
      this.first = 'NA',
      this.last = 'NA',
      this.email,
      this.contact});

  factory Person.fromMap(Map<dynamic, dynamic> data) {
    return Person(
      id: data['id'] as int,
      first: data['first'] as String,
      last: data['last'] as String,
      email: data['email'] as String,
      contact: data['contact'] as String,
    );
  }
  Map<String, dynamic> toMap() => {
        "id": id,
        "first": first,
        "last": last,
        "email": email,
        "contact": contact
      };
}
