import 'package:flutter/material.dart';
import 'package:virvebook/helpers/http_helper.dart';
// import 'home_page.dart';

class ContactPage extends StatefulWidget {
  final String id;

  ContactPage({@required this.id});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<dynamic>(
            future: HttpHelper().getUsersByID(widget.id),
            builder: (context, snapshot) {
              var apiData = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      child: Icon(
                        Icons.person,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Text('Update Contact'),
                                  content: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Form(
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                            controller: fNameController,
                                            decoration: InputDecoration(
                                              labelText: 'First Name',
                                              icon: Icon(Icons.person),
                                            ),
                                          ),
                                          TextFormField(
                                            controller: lNameController,
                                            decoration: InputDecoration(
                                              labelText: 'Last Name',
                                              icon: Icon(Icons.person),
                                            ),
                                          ),
                                          TextFormField(
                                            controller: phoneController,
                                            decoration: InputDecoration(
                                              labelText: 'Phone Number',
                                              icon: Icon(Icons.phone),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    MaterialButton(
                                      child: Text('Update'),
                                      onPressed: () {
                                        // your code
                                        setState(
                                          () {
                                            if (fNameController.text.isNotEmpty &&
                                                lNameController
                                                    .text.isNotEmpty &&
                                                phoneController
                                                    .text.isNotEmpty) {
                                              HttpHelper()
                                                  .putRequest(
                                                url:
                                                    'http://192.168.43.186:3000/api/v1/contact/${widget.id}',
                                                fname: fNameController.text,
                                                lname: lNameController.text,
                                                phone: phoneController.text,
                                              )
                                                  .then((value) {
                                                Navigator.pop(context);
                                              });
                                            } else {
                                              print(
                                                  'one of the fields are empty');
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.create_outlined,
                          color: Colors.lightBlue,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          apiData['fname'],
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          apiData['lname'],
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      apiData['phone'],
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    MaterialButton(
                      child: Text(
                        'DELETE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Contact'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        'Are you sure you want to delete this contact'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      HttpHelper()
                                          .getDeleteUser('${widget.id}')
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    });
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Cancel',
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              } else if (!snapshot.hasData) {
                return Text('No data');
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
