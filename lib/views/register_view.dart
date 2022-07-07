import 'package:flutter/material.dart';
import 'package:myapp/constants/routes.dart';
import 'package:myapp/services/auth/auth_exceptions.dart';
import 'package:myapp/utilities/show_error_dialog.dart';
import 'package:myapp/services/auth/auth_service.dart';

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
                final userCredentails = await AuthService.firebase().creatUser(
                  email: email,
                  password: password,
                );
                AuthService.firebase().sendEmailVerification();
                
                Navigator.of(context).pushNamed(verifyEmailRoute);
             
              } on EmailAlreadyInUseAuthException{
                await showErrorDialog(
                  context,
                  "Email is registered",
                );
              }on WeakPasswordAuthException{
                await showErrorDialog(
                  context,
                  "Weak password",
                );
              }on InvalidEmailAuthException{
await showErrorDialog(
                  context,
                  "Invalid email",
                );
              } on GenricAuthException{
                await showErrorDialog(
                  context,
                  "Failed to register!",
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
