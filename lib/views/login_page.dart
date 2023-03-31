import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loyalappco/views/home_page.dart';
import 'package:loyalappco/views/register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  bool isLogged = FirebaseAuth.instance.currentUser != null;

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    if (!isLogged) {
      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Material(
            color: Colors.white,
            child: ListView(
              children: [
                Center(
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
                        'Login',
                        style: GoogleFonts.rubik(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      // ! LOGIN FORM
                      const MyLoginForm(),
                      // ! REGISTER BUTTON
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5025F4),
                              minimumSize: const Size.fromHeight(50)),
                          child: const Text('Register',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Text(
        'giris yapmissin ztn knk',
        textDirection: TextDirection.ltr,
      );
    }
  }
}

class MyLoginForm extends StatefulWidget {
  const MyLoginForm({super.key});

  @override
  MyLoginFormState createState() {
    return MyLoginFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyLoginFormState extends State<MyLoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  bool isLogin = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

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

  Future<void> signInWithEmailAndPassword() async {
    try {
      if (_controllerEmail.text.isEmpty || _controllerPassword.text.isEmpty) {
        _showMyDialog('Warning', 'E-mail or password cannot be empty.');
      } else {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
        );
        setState(() {
          isLogin = true;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        _showMyDialog('Warning', 'User not found. Check e-mail again.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        _showMyDialog('Warning', 'Wrong password. Check password again.');
      }
    }
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
                  obscureText: true,
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
                // ! LOGIN BUTTON
                ElevatedButton(
                  onPressed: () {
                    signInWithEmailAndPassword();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomePage()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5025F4),
                      minimumSize: const Size.fromHeight(50)),
                  child: const Text('Login', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
