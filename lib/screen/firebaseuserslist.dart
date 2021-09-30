import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseUsersList extends StatefulWidget {
  const FirebaseUsersList({ Key? key }) : super(key: key);

  @override
  _FirebaseUsersListState createState() => _FirebaseUsersListState();
}

class _FirebaseUsersListState extends State<FirebaseUsersList> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  CollectionReference userlist =
      FirebaseFirestore.instance.collection('userslist');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      name.text = documentSnapshot['name'];
      email.text = documentSnapshot['email'];
      username.text = documentSnapshot['username'];
      password.text = documentSnapshot['passowrd'];
    }


    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: username,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: password,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? txtname = name.text;
                    final String? txtemail = email.text;
                    final String? txtusername = username.text;
                    final String? txtpassword = password.text;
                    if (txtname != null && txtemail != null && txtusername != null && txtpassword != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await userlist.add({"name": txtname, "email": txtemail, "username": txtusername, "password": txtpassword});
                      }

                      if (action == 'update') {
                        // Update the product
                        await userlist
                            .doc(documentSnapshot!.id)
                            .update({"name": txtname, "email": txtemail, "username": txtusername, "password": txtpassword});
                      }

                      // Clear the text fields
                      name.text = '';
                      email.text = '';
                      username.text = '';
                      password.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String userId) async {
    await userlist.doc(userId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have successfully deleted a user')));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserList from Firebase'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: userlist.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Name: "+documentSnapshot['name']),
                    subtitle: Text("Email: "+documentSnapshot['email']+", Username: "+documentSnapshot['username']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: Icon(Icons.add),
      ),
    );
  }
}