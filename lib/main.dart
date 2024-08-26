import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';

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
  final _successColor = const Color.fromRGBO(39, 178, 116, 1);
  final _errorColor = const Color.fromRGBO(255, 128, 128, 1);
  String _email = '';
  String _password = '';
  bool _submitted = false;
  bool _isPasswordVisible = false;

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
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              fontSize: 13,
              color: hasError ? _errorColor : _successColor,
            )
          ),
        )
      : const SizedBox.shrink();
  }

  Color _getInputTextColor(bool submitted, bool hasErrors) {
    return submitted ? (hasErrors ? _errorColor : _successColor) : const Color.fromRGBO(21, 29, 81, 1);
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
                Color.fromRGBO(244, 249, 255, 1),
                Color.fromRGBO(224, 237, 251, 1),
              ],
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Positioned(
                    top: 200,
                    left: 100,
                    child: Image.asset(
                      'images/star.png',
                      height: 25,
                      width: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120, bottom: 36),
                    child: Center(
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Color.fromRGBO(74, 78, 113, 1),
                         )
                        ),
                      ),
                      
                    ),
                  ),
                  TextFormField(
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: _getInputTextColor(_submitted, _emailErrors.values.any((e) => e)),
                      )
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 13, bottom: 13),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Create your email',
                      hintStyle: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(111, 145, 188, 1)
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _submitted ? (_emailErrors.values.any((e) => e) ? _errorColor : _successColor) : Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _submitted ? (_emailErrors.values.any((e) => e) ? _errorColor : _successColor) : const Color.fromRGBO(111, 145, 188, 1),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildErrorText('Email is required', _emailErrors['empty']!),
                        _buildErrorText('Invalid email address', _emailErrors['format']!),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: _getInputTextColor(_submitted, _passwordErrors.values.any((e) => e)),
                      )
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 13, bottom: 13),
                      hintText: 'Create your password',
                      hintStyle: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(111, 145, 188, 1)
                        )
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _submitted ? (_passwordErrors.values.any((e) => e) ? _errorColor : _successColor) : Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: _submitted ? (_passwordErrors.values.any((e) => e) ? _errorColor : _successColor) : const Color.fromRGBO(111, 145, 188, 1),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          color: _getInputTextColor(_submitted, _passwordErrors.values.any((e) => e)),
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_isPasswordVisible,
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                        if (_submitted) _validatePassword(value);
                      });
                    },
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildErrorText('Password is required', _passwordErrors['empty']!),
                        _buildErrorText('8 characters or more (no spaces)', _passwordErrors['lengthMin']!),
                        _buildErrorText('No more than 64 characters', _passwordErrors['lengthMax']!),
                        _buildErrorText('Uppercase and lowercase letters', _passwordErrors['uppercase']!),
                        _buildErrorText('At least one digit', _passwordErrors['digit']!),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      height: 48,
                      width: 240,
                      child: GradientElevatedButton(
                        onPressed: _submitForm,
                        style: GradientElevatedButton.styleFrom(
                          gradient: const LinearGradient(colors: [
                            Color.fromRGBO(112, 194, 255, 1),
                            Color.fromRGBO(80, 112, 255, 1),
                          ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                          )
                          ),
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
