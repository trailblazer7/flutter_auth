import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Up',
      home: AuthorizationForm(),
    );
  }
}

class AuthorizationForm extends StatefulWidget {
  const AuthorizationForm({super.key});

  @override
  _AuthorizationFormState createState() => _AuthorizationFormState();
}

class _AuthorizationFormState extends State<AuthorizationForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _submitted = false;

  Map<String, bool> _emailErrors = {
    'empty': false,
    'format': false,
  };
  Map<String, bool> _passwordErrors = {
    'empty': false,
    'lengthMin': false,
    'lengthMax': false,
    'uppercase': false,
    'digit': false,
  };

  void _validateEmail(String value) {
    _emailErrors['empty'] = value.isEmpty;
    _emailErrors['format'] = !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
  }

  void _validatePassword(String value) {
    _passwordErrors['empty'] = value.isEmpty;
    _passwordErrors['lengthMin'] = value.length < 8;
    _passwordErrors['lengthMax'] = value.length > 64;
    _passwordErrors['uppercase'] = !RegExp(r'[A-Z]').hasMatch(value);
    _passwordErrors['digit'] = !RegExp(r'[0-9]').hasMatch(value);
  }

  void _submitForm() {
    setState(() {
      _submitted = true;
      _validateEmail(_email);
      _validatePassword(_password);
    });

    if (_emailErrors.values.every((e) => !e) && _passwordErrors.values.every((e) => !e)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign up'),
            content: const Text('Sign up success'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildErrorText(String message, bool hasError) {
    return _submitted
      ? Text(
          message,
          style: TextStyle(
            color: hasError ? Colors.red : Colors.green,
          ),
        )
      : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _submitted && _emailErrors.values.any((e) => e) ? Colors.red : Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _submitted && _emailErrors.values.any((e) => e) ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                        if (_submitted) _validateEmail(value);
                      });
                    },
                  ),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildErrorText('Email is required', _emailErrors['empty']!),
                      _buildErrorText('Invalid email address', _emailErrors['format']!),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _submitted && _passwordErrors.values.any((e) => e) ? Colors.red : Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _submitted && _passwordErrors.values.any((e) => e) ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                        if (_submitted) _validatePassword(value);
                      });
                    },
                  ),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildErrorText('Password is required', _passwordErrors['empty']!),
                      _buildErrorText('8 characters or more (no spaces)', _passwordErrors['lengthMin']!),
                      _buildErrorText('No more than 64 characters', _passwordErrors['lengthMax']!),
                      _buildErrorText('Uppercase and lowercase letters', _passwordErrors['uppercase']!),
                      _buildErrorText('At least one digit', _passwordErrors['digit']!),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
