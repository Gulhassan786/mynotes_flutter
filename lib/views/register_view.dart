//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import '../firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'package:myapp/constants/routes.dart';
import 'package:myapp/utilities/show_error_dialog.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
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
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == "email-already-in-use") {
                  await showErrorDialog(
                    context,
                    "Email is registered",
                  );
                } else if (e.code == "weak-password") {
                  await showErrorDialog(
                    context,
                    "Weak password",
                  );
                } else if (e.code == "invalid-email") {
                  await showErrorDialog(
                    context,
                    "Invalid email",
                  );
                } else {
                  await showErrorDialog(
                    context,
                    "Error: ${e.code}",
                  );
                }
              } catch (e) {
                await showErrorDialog(
                  context,
                  e.toString(),
                );
              }
            },
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text("Already registered? Login here!"),
          ),
        ],
      ),
    );
  }
}
