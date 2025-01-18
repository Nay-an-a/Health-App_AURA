import 'package:flutter/material.dart';
import 'package:new_project/homepage.dart';
class Login extends StatefulWidget {
  Map<String,String> user;
  Login({Key?key,required this.user}):super(key:key);
  @override
  _login createState() => _login();
}

class _login extends State<Login> {
  String? _username;
  String? _password;
  String? _errorMessage = null;
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Center(child:SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

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
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
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
                    print("$_username and ${widget.user['_username']}");
                    print("$_password and ${widget.user['_password']}");
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                    }
                    if (_username == widget.user['_username'] && _password == widget.user['_password']) {
                      print("Hello");
                      setState(() {
                        _errorMessage = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Login Successful",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.blue,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage(user: widget.user)));
                    } else {
                      print(_username);
                      print(_password);
                      setState(() {
                        _errorMessage = "Incorrect username or password";
                        ;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Login unsuccessful",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.blue,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    ),
    )
    );
  }
}
