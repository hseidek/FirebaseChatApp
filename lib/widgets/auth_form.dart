import 'package:flutter/material.dart';

class Auth_Form extends StatefulWidget {
  Auth_Form(this.submitFn, this.isLoading);

  final bool isLoading;

  final void Function(String email, String password, String username,
      bool isLogin, BuildContext ctx) submitFn;

  @override
  _Auth_FormState createState() => _Auth_FormState();
}

class _Auth_FormState extends State<Auth_Form> {
  final _formkey = GlobalKey<
      FormState>(); // here we give the form a unique key to be able to access it and to can validate
  var _userEmail;
  var _userName;
  var _userPassword;

  bool _isLogin = true; // here we need to switch between login and signup

  void _trySubmit() {
    final isValid = _formkey.currentState!.validate();
    // here we build this method to pass it to the button as it will trigger all the validtors in all the form

    FocusScope.of(context).unfocus();
    // this to close the soft keyboard after entering the valid inputs
    if (isValid) {
      // we make a check statement if all validtors return null means the user entered a right a valid value
      _formkey.currentState!.save();
      // if it true will call save to save all the entered values ( by onsaved that be exist in all the form )
      widget.submitFn(_userEmail, _userName,
          _userPassword, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formkey, // here we assigned the key to he form
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty || !value!.contains('@'))
                          return 'Please Enter a valid Email ';
                        else
                          return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                      ),
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        onSaved: (value) {
                          _userName = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty || value!.length < 4)
                            return 'please enter at least 4 characters';
                          else
                            return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'User name',
                        ),
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      onSaved: (value) {
                        _userPassword = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty || value!.length < 7)
                          return 'please enter at least 7 characters';
                        else
                          return null;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      ElevatedButton(
                          onPressed: _trySubmit,
                          child: Text(_isLogin ? 'Login' : 'Signup')),
                    if (!widget.isLoading)
                      TextButton(
                        child: Text(
                          _isLogin
                              ? 'Create new account'
                              : 'I already have an account',
                        ),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
