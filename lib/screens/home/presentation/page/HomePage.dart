import 'dart:js';

import 'package:flutter/material.dart';
import 'package:testapp1/screens/home/data/local/Database.dart';
import 'package:testapp1/screens/home/domain/Person.dart';

class HomePage extends StatelessWidget {
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final emailController = TextEditingController();
  final contactConroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: firstController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                      onSaved: (String? value) {},
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: lastController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                      onSaved: (String? value) {},
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      onSaved: (String? value) {},
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: contactConroller,
                      decoration: const InputDecoration(
                        labelText: 'Contact',
                      ),
                      onSaved: (String? value) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: Text("Save"),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: _saveFormData,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: LocalStorage.db.getAllPersons(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Something went Wrong..'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    print(snapshot.data);

                    // I'm getting error to typecast the object to List<Person>
                    List<Person> data = snapshot.data;
                    return dataList(data);
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _saveFormData() {
    Person person = Person(
        id: 0,
        first: firstController.text,
        last: lastController.text,
        email: emailController.text,
        contact: contactConroller.text);

    LocalStorage.db.insert(person);

    firstController.clear();
    lastController.clear();
    emailController.clear();
    contactConroller.clear();

    LocalStorage.db.getAllPersons().then((value) => print(value));
  }

  Widget dataList(List<Person>? persons) {
    return ListView.builder(
        itemCount: persons?.length,
        itemBuilder: (context, index) {
          Person person = persons![index];
          return ListTile(
            title: Text(person.first),
            subtitle: Text(person.last),
          );
        });
  }
}
