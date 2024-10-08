import 'package:flutter/material.dart';
import 'package:flutter_auth/styles/styles.dart';
import 'package:flutter_auth/widgets/bottom_icons.dart';
import 'package:flutter_auth/widgets/custom_text_form_field.dart';
import 'package:flutter_auth/widgets/error_text.dart';
import 'package:flutter_auth/widgets/form_title.dart';
import 'package:flutter_auth/widgets/sign_up_button.dart';

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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

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
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: isPortrait ? 30 : 0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    (isPortrait ? SizedBox(
                      height: 17,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 30,
                            child: Image.asset(
                              'images/star.png',
                              height: 17,
                              width: 17,
                            ),
                          ),
                        ],
                      ),
                    ): const SizedBox.shrink()),
                    Padding(
                      padding: EdgeInsets.only(
                        top: isPortrait ? 70 : 0,
                        bottom: isPortrait ? 23 : 0,
                      ),
                      child: const FormTitle(title: 'Sign up')
                    ),
                    CustomTextFormField(
                      hintText: 'Create your email',
                      hasError: _emailErrors.values.any((e) => e),
                      submitted: _submitted,
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                          if (_submitted) _validateEmail(value);
                        });
                      },
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: isPortrait ? 5 : 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ErrorText(submitted: _submitted, message: 'Email is required', hasError: _emailErrors['empty']!, isPortrait: isPortrait),
                          ErrorText(submitted: _submitted, message: 'Invalid email address', hasError: _emailErrors['format']!, isPortrait: isPortrait),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                          if (_submitted) _validatePassword(value);
                        });
                      },
                      submitted: _submitted,
                      hasError: _passwordErrors.values.any((e) => e),
                      hintText: 'Create your password',
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          color: _submitted ? (_passwordErrors.values.any((e) => e) ? AppColors.errorColor : AppColors.successColor) : const Color.fromRGBO(21, 29, 81, 1),
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
                    const SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: isPortrait ? 8 : 2, bottom: isPortrait ? 20 : 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ErrorText(submitted: _submitted, message: 'Password is required', hasError: _passwordErrors['empty']!, isPortrait: isPortrait),
                          ErrorText(submitted: _submitted, message: '8 characters or more (no spaces)', hasError: _passwordErrors['lengthMin']!, isPortrait: isPortrait),
                          ErrorText(submitted: _submitted, message: 'No more than 64 characters', hasError: _passwordErrors['lengthMax']!, isPortrait: isPortrait),
                          ErrorText(submitted: _submitted, message: 'Uppercase and lowercase letters', hasError: _passwordErrors['uppercase']!, isPortrait: isPortrait),
                          ErrorText(submitted: _submitted, message: 'At least one digit', hasError: _passwordErrors['digit']!, isPortrait: isPortrait),
                        ],
                      ),
                    ),
                    SizedBox(height: isPortrait ? 20 : 0),
                    Center(
                      child: SizedBox(
                        height: 48,
                        width: 240,
                        child: SignUpButton(onPressed: _submitForm)
                      )
                    ),
                    isPortrait ? const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                        child: BottomIcons()
                      )
                    ) : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}