import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './db_store.dart';
import '../constant.dart';
import '../screens/home_screen.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _isLogin = true;
  bool _isPasswordHidden = true;
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _username = '';
  String _password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isStartRegister = false;

  Future<void> tryLoginUser(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authUser;
    try {
      setState(() {
        _isStartRegister = true;
      });
      if (isLogin) {
        authUser = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        await DBStore.setData('username', _username);
        authUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      if (mounted) {
        setState(() {
          _isStartRegister = false;
        });
      }
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on PlatformException catch (err) {
      setState(() {
        _isStartRegister = false;
      });
      String msg = 'Something went wrong please try again later';
      if (err.message != null) {
        //msg = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (err) {
      setState(() {
        _isStartRegister = false;
      });
      Scaffold.of(ctx).showSnackBar(
        const SnackBar(
          content: Text('Some error occurred'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void onSave() async {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (isValid!) {
      _formKey.currentState?.save();
      await tryLoginUser(
        _email.trim(),
        _password.trim(),
        _username,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                key: const ValueKey('email'),
                keyboardType: TextInputType.emailAddress,
                decoration: klogininput,
                validator: (value) {
                  if (value != null) {
                    if (!value.contains('@')) {
                      return 'Please enter a valid e-mail address';
                    }
                    return null;
                  }
                  return 'Please enter a valid e-mail address';
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              const SizedBox(height: 20),
              if (!_isLogin)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    key: const ValueKey('user'),
                    decoration: klogininput.copyWith(
                      labelText: 'username',
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: kdarkBlue,
                      ),
                    ),
                    validator: (value) {
                      if (value != null) {
                        if (value.length < 4) {
                          return 'Username must be 4 characters long';
                        }
                        return null;
                      }
                      return 'Username must be 4 characters long';
                    },
                    onSaved: (value) {
                      _username = value!;
                    },
                  ),
                ),
              TextFormField(
                key: const ValueKey('password'),
                obscureText: _isPasswordHidden,
                decoration: klogininput.copyWith(
                  suffixIcon: _isPasswordHidden
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordHidden = !_isPasswordHidden;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility_outlined,
                            color: kdarkBlue,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordHidden = !_isPasswordHidden;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility_off_outlined,
                            color: kdarkBlue,
                          ),
                        ),
                  labelText: 'Password',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: kdarkBlue,
                  ),
                ),
                validator: (value) {
                  if (value != null) {
                    if (value.length < 8) {
                      return 'Password must be 8 characters long';
                    }
                    return null;
                  }
                  return 'Password must be 8 characters long';
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              const SizedBox(height: 20),
              if (_isStartRegister) const CircularProgressIndicator(),
              if (!_isStartRegister)
                ElevatedButton(
                  child: Text(
                    _isLogin ? 'Login' : 'Register',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: onSave,
                ),
              const SizedBox(height: 50),
              if (!_isStartRegister)
                Text(
                  _isLogin
                      ? 'Don\'t have any account.'
                      : 'Already have an account.',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kdarkBlue,
                  ),
                ),
              if (!_isStartRegister)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin ? 'Register' : 'Login',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kdarkBlue,
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
