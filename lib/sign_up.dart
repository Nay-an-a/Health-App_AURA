import'package:flutter/material.dart';
import 'package:new_project/login.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  String? name, emailId, password, phoneNumber, _username, _password;
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter valid Name";
                    }
                    return null;
                  },
                  onSaved: (value) => name = value,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                TextFormField(
                  decoration: InputDecoration(labelText: "Phone Number"),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.length < 10 ||
                        value.length > 10) {
                      return "Enter a Valid Phone number";
                    }
                    return null;
                  },
                  onSaved: (value) => phoneNumber = value,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                TextFormField(
                  decoration: InputDecoration(labelText: "Email Id"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  onSaved: (value) => emailId = value,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter a valid username";
                    }
                    return null;
                  },
                  onSaved: (value) => _username = value,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter a valid password";
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value,
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      print(_username);
                      print(_password);
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                      }
                      if (name == null ||
                          phoneNumber == null ||
                          emailId == null ||
                          _username == null ||
                          _password == null||
                      phoneNumber!.length < 10 ||
                          phoneNumber!.length > 10) {
                        setState(() {
                          _errorMessage = "All fields are mandatory";
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Signup Unsuccessful!",
                            ),
                          ),
                        );
                      } else {
                        setState(() {
                          _errorMessage = null;
                        });
                        Map<String,String> user={
                          'name':name!,'phoneno':phoneNumber!,'emailId':emailId!,'_username':_username!,'_password':_password!
                        };
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(user:user)));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Signed up successfully!",
                            ),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
