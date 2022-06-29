import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/views/register_view.dart';
import 'firebase_options.dart';
import 'views/login_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage()),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            // checking if future is done then return whole column otherwise return Loding text
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                print(user);
                if (user?.emailVerified ?? false) {
                  return const Text("Done");
                } else {
                  return const VerifyEmailView();
                }
              // return const RegistarPage();
              // return const LoginView();

              default:
                return const Text("Loding...");
            }
          },
        ));
  }
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text("Please verify your email address"),
      TextButton(
        onPressed: () async {
          final user = FirebaseAuth.instance.currentUser;
          // print(user);
          await user?.sendEmailVerification();
        },
        child: const Text("Send email verification"),
      )
    ]);
  }
}
