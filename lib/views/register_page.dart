import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalappco/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loyalappco/views/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/logo-purple.png',
              width: 250,
            ),
            Text(
              // * heading
              'Register',
              style:
                  GoogleFonts.rubik(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            // ! REGISTER FORM
            const MyRegisterForm(),
          ],
        ),
      ),
    );
  }
}

class MyRegisterForm extends StatefulWidget {
  const MyRegisterForm({super.key});

  @override
  MyRegisterFormState createState() {
    return MyRegisterFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyRegisterFormState extends State<MyRegisterForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerDisplayName = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> _showMyDialog(String title, String desc) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(desc),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                // ! EMAIL
                Row(
                  children: const [
                    Icon(Icons.mail),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "E-mail",
                      style: TextStyle(fontSize: 18, letterSpacing: 1),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _controllerEmail,
                  style: const TextStyle(fontSize: 24),
                  decoration: const InputDecoration(
                    hintText: 'janedoe@example.com',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Color(0xFF5025F4)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // ! PASSWORD
                Row(
                  children: const [
                    Icon(Icons.lock),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(fontSize: 18, letterSpacing: 1),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _controllerPassword,
                  style: const TextStyle(fontSize: 24),
                  decoration: const InputDecoration(
                    hintText: '********',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Color(0xFF5025F4)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // ! REGISTER BUTTON
                ElevatedButton(
                  onPressed: () async {
                    try {
                      if (_controllerEmail.text.isEmpty ||
                          _controllerPassword.text.isEmpty) {
                        _showMyDialog('Warning',
                            'E-mail or password cannot be empty.');
                      }else{
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: _controllerEmail.text,
                          password: _controllerPassword.text,
                        );
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()),
                      );
                      }
                      
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                        _showMyDialog('Warning',
                            'There is an account with that e-mail.');
                      }
                    } catch (e) {
                      print(e);
                    }

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const HomePage()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5025F4),
                      minimumSize: const Size.fromHeight(50)),
                  child: const Text('Register', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
