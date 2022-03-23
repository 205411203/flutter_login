import 'package:cloud_firestore/cloud_firestore.dart';
import 'update_staff_page.dart';
import 'package:flutter/material.dart';

class ListStaffPage extends StatefulWidget {
  const ListStaffPage({Key? key}) : super(key: key);

  @override
  State<ListStaffPage> createState() => _ListStaffPageState();
}

class _ListStaffPageState extends State<ListStaffPage> {
  final Stream<QuerySnapshot> StaffsStream =
  FirebaseFirestore.instance.collection('Staffs').snapshots();

  CollectionReference Staffs =
  FirebaseFirestore.instance.collection('Staffs');
  Future<void> deleteUser(id) {
    return Staffs
        .doc(id)
        .delete()
        .then((value) => print("user Deleted"))
        .catchError((error) => ('faliled to delete $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: StaffsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final List storedocs = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          storedocs.add(a);
          a['id'] = document.id;
        }).toList();
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                1: FixedColumnWidth(140)
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  TableCell(
                      child: Container(
                        color: Colors.greenAccent,
                        child: Center(
                          child: Text("Name",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                      )),
                  TableCell(
                      child: Container(
                        color: Colors.greenAccent,
                        child: Center(
                          child: Text("Email",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                      )),
                  TableCell(
                      child: Container(
                        color: Colors.greenAccent,
                        child: Center(
                          child: Text("Action",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                      ))
                ]),
                for (var i = 0; i < storedocs.length; i++) ...[
                  TableRow(children: [
                    TableCell(
                        child: Center(
                          child: Text(storedocs[i]['name'],
                              style: TextStyle(
                                fontSize: 18.0,
                              )),
                        )),
                    TableCell(
                        child: Center(
                          child: Text(storedocs[i]['email'],
                              style: TextStyle(
                                fontSize: 18.0,
                              )),
                        )),
                    TableCell(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdateStaffPage(id :storedocs[i]['id']),
                                      ))
                                },
                                icon: Icon(Icons.edit),
                                color: Colors.orange,
                              ),
                              IconButton(
                                onPressed: () => {deleteUser(storedocs[i]['id'])},
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              )
                            ]))
                  ]),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}