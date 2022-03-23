import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStaffPage extends StatefulWidget {
  final String id;
  const UpdateStaffPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<UpdateStaffPage> createState() => _UpdateStaffPageState();
}

class _UpdateStaffPageState extends State<UpdateStaffPage> {
  final _formKey = GlobalKey<FormState>();
  var name = "";
  var email = "";
  var password = "";

  CollectionReference Staffs =
  FirebaseFirestore.instance.collection('Staffs');
  Future<void> updateUser(id,name,email,password) {
    return Staffs
        .doc(id)
        .update({'name':name,'email':email,'password':password})
        .then((value) => print("user Updated"))
        .catchError((error) => ('faliled to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Status"),
      ),
      body: Form(
          key: _formKey,
          // getting specific data by ID
          child: FutureBuilder <
              DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('Staffs')
                  .doc(widget.id)
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.hasError) {
                  print("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var data = snapshot.data!.data();
                var name = data!['name'];
                var email = data['email'];
                var password = data['password'];

                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 30.0),
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 30.0),
                        child: TextFormField(
                          initialValue: 'Nazim',
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'Name :',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15.0),
                          ),
                          onChanged: (value) => name=value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Name";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 30.0),
                        child: TextFormField(
                          autofocus: false,
                          initialValue: 'nazim9873@gmail.com',
                          onChanged: (value) => email=value,
                          decoration: InputDecoration(
                            labelText: 'Email :',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15.0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Email";
                            } else if (!value.contains('@')) {
                              return "Please Enter Valid Email";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 30.0),
                        child: TextFormField(
                          autofocus: false,
                          obscureText: true,
                          initialValue: '34324234',
                          onChanged: (value) => password=value,
                          decoration: InputDecoration(
                            labelText: 'Password :',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15.0),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Password";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      updateUser(widget.id,name,email,password);
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                child: Text(
                                  'Update',
                                  style: TextStyle(fontSize: 18.0),
                                )),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueGrey),
                                onPressed: () => {},
                                child: Text(
                                  'Reset',
                                  style: TextStyle(fontSize: 18.0),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }
}