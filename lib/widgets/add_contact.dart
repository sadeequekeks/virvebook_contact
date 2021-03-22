import 'package:flutter/material.dart';
import 'package:virvebook/helpers/http_helper.dart';

class AddContact extends StatefulWidget {
  AddContact({Key key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xff757575),
        child: Container(
          height: 400.0,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Contact',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40.0, color: Colors.lightBlueAccent),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: fNameController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  labelText: 'Enter First Name',
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter First Name',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                onChanged: (newText) {
                  // newTaskTitle = newText;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: lNameController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  labelText: 'Enter Last Name',
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter Last Name',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                onChanged: (newText) {
                  // newTaskTitle = newText;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 30.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (fNameController.text.isNotEmpty &&
                        lNameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty) {
                      HttpHelper()
                          .postRequest(
                        url: 'http://192.168.43.186:3000/api/v1/contact',
                        fname: fNameController.text,
                        lname: lNameController.text,
                        phone: phoneController.text,
                      )
                          .then((value) {
                        Navigator.pop(context);
                      });
                    } else {
                      print('one of the fields are empty');
                    }
                  });
                },
                child: Text(
                  'ADD',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
