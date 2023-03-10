
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewPage extends StatefulWidget {
  const RegisterViewPage({super.key});

  @override
  State<RegisterViewPage> createState() => _RegisterViewPageState();
}

class _RegisterViewPageState extends State<RegisterViewPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register'),),
      body: Column(
        children: [
          TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Please enter your email',
              )),
          TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Please enter your password',
              )),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try{
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                print(userCredential);
              }on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password'){
                  print('Weak password');
                } else if (e.code == 'email-already-in-use'){
                  print('Email already in use');
                } else if (e.code == 'invalid-email') {
                  print('Invalid email');
                }
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
              onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil('/logIn/',
                        (route) => false);
              },
              child: const Text('Already Registered? LogIn here!'))
        ],
      ),
    );
  }
}
