import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseUsersList extends StatefulWidget {
  const FirebaseUsersList({ Key? key }) : super(key: key);

  @override
  _FirebaseUsersListState createState() => _FirebaseUsersListState();
}

class _FirebaseUsersListState extends State<FirebaseUsersList> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  CollectionReference userslist = FirebaseFirestore.instance.collection('userslist');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'Create';
    if (documentSnapshot != null) {
      action = 'Update';
      nameController.text = documentSnapshot['name'];
      emailController.text = documentSnapshot['email'];
      usernameController.text = documentSnapshot['username'];
      passwordController.text = documentSnapshot['password'];
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
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final String? name = nameController.text;
                  final String? email = emailController.text;
                  final String? username = usernameController.text;
                  final String? password = passwordController.text;
                  if(name != null && email != null && username != null && password != null) {
                    if(action == 'Create') {
                      //Add new user to Firebase Database
                      await userslist.add({"name": name, "email": email, "username": username, "password": password});
                    }
                    if(action == 'Update') {
                      //Update user data to Firebase Database
                      await userslist.doc(documentSnapshot!.id).update({"name": name, "email": email, "username": username, "password": password});
                    }

                    nameController.text = '';
                    emailController.text = '';
                    usernameController.text = '';
                    passwordController.text = '';

                    Navigator.of(context).pop();
                  }
                },
                child: Text(action == 'Create' ? 'Create' : 'Update')
              ),
              SizedBox(
                height: 250,
              )
            ],
          ),
        );
      }
    );
  }

  Future<void> _deleteProduct(String productId) async {
    await userslist.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You have successfully deleted a product'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserList from Firebase'),
      ),
      body: StreamBuilder(
        stream: userslist.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Name: "+documentSnapshot['name']),
                    subtitle: Text("Email: "+documentSnapshot['email']+", Username: "+documentSnapshot['username']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => _createOrUpdate(documentSnapshot),
                            icon: Icon(Icons.edit)
                          ),
                          IconButton(
                            onPressed: () => _deleteProduct(documentSnapshot.id),
                            icon: Icon(Icons.delete)
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: Icon(Icons.add),
      ),
    );
  }
}