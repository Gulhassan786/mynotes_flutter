import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';

class RegistarPage extends StatefulWidget {
  const RegistarPage({Key? key}) : super(key: key);

  @override
  State<RegistarPage> createState() => _RegistarPageState();
}

class _RegistarPageState extends State<RegistarPage> {
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
    return Column(
      children: [
        TextField(
          controller: _email,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(hintText: "Enter your Email"),
          keyboardType: TextInputType.emailAddress,
        ),
        TextField(
          controller: _password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(hintText: "Enter your password"),
        ),
        TextButton(
          onPressed: () async {
            final email = _email.text.trim();
            final password = _password.text.trim();
            try {
              final UserCredential =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
            } on FirebaseAuthException catch (e) {
              if (e.code == "email-already-in-use") {
                print("Mail is registered");
              } else if (e.code == "weak-password") {
                print("Weak Password");
              } else if (e.code == "invalid-email") {
                print('Invalid Email');
              }
            }
          },
          child: const Text("Register"),
        ),
      ],
    );
  }
}
