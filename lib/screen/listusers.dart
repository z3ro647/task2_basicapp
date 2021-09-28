import 'package:flutter/material.dart';
import 'package:task2_basicapp/database/sql_helper.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListUsers',
      home: ListUsersHomePage(),
    );
  }
}

class ListUsersHomePage extends StatefulWidget {
  const ListUsersHomePage({Key? key}) : super(key: key);

  @override
  _ListUsersHomePageState createState() => _ListUsersHomePageState();
}

class _ListUsersHomePageState extends State<ListUsersHomePage> {
  // All users
  List<Map<String, dynamic>> _users = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshUserList() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _users = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshUserList();
  }

  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingUser = _users.firstWhere((element) => element['id'] == id);
      name.text = existingUser['name'];
      email.text = existingUser['email'];
      mobile.text = existingUser['mobile'];
      password.text = existingUser['password'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        builder: (_) => Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              height: 1200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: name,
                    decoration: InputDecoration(hintText: 'Name'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: email,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: mobile,
                    decoration: InputDecoration(hintText: 'Mobile'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: password,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: confirmpassword,
                    decoration: InputDecoration(hintText: 'Confirm Password'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new user
                      if (id == null) {
                        await _addItem();
                      }

                      if (id != null) {
                        await _updateItem(id);
                      }

                      // Clear the text fields
                      name.text = '';
                      email.text = '';
                      mobile.text = '';
                      password.text = '';
                      confirmpassword.text = '';

                      // Close the bottom sheet
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  // Insert a new users to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        name.text, email.text, mobile.text, password.text);
    _refreshUserList();
  }

  // Update an existing user from the database
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, name.text, email.text, mobile.text, password.text);
    _refreshUserList();
  }

  // Delete a user
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('User Deleted'),
    ));
    _refreshUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: EdgeInsets.all(15),
                child: Card(
                  elevation: 2.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(_users[index]['name']),
                          Text(_users[index]['email']),
                          Text(_users[index]['mobile']),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _showForm(_users[index]['id']),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteItem(_users[index]['id']),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
