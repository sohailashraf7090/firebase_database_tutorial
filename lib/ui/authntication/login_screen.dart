import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database_tutorial/ui/authntication/signup_screen.dart';
import 'package:firebase_database_tutorial/ui/posts/post_screen.dart';
import 'package:firebase_database_tutorial/utils/utils.dart';
import 'package:firebase_database_tutorial/widgets/round_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Login Screen"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "Enter your email",
                          labelText: "Email"),
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Enter your email";
                        }
                        return null;
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_open),
                          hintText: "Enter your password",
                          labelText: "password"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your password";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: RoundedButton(
                loading: loading,
                title: "Login",
                onTap: (() {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    _auth
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text.toString())
                        .then((value) {
                      Utils().toastMessege(value.user.toString());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PostScreen()));
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      debugPrint(error.toString());
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessege(error.toString());
                    });
                  }
                }),
              )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: const Text("Sign up"))
                ],
              )
            ]),
      ),
    );
  }
}
