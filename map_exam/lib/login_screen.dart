import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const LoginScreen());
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth= FirebaseAuth.instance;
  //late bool _success;
  

  

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

   void signIn(String email, String password) async {
    try {
          await _auth
              .signInWithEmailAndPassword(email: email, password: password)
              .then((user) async {

            navigator.pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen(email:email)));
          });
        }catch (e) {
      return null;
    }
   }

    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Please sign in', style: TextStyle(fontSize: 35.0)),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration:
                    const InputDecoration(hintText: 'Type your email here'),
                onTap: () {},
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Type your password',
                ),
                onTap: () {},
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(child: const Text('Sign in'), onPressed: () {
                signIn(_emailController.text, _passwordController.text);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
