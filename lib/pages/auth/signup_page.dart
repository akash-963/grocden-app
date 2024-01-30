import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget{
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signup() async {
    if(_formkey.currentState!.validate()){
      try {
        await _auth
            .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text
        );
        Navigator.pushReplacementNamed(context, '/shopDetails');
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
          duration: Duration(seconds: 5),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Center(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: 'Enter Email',
                        labelText: 'Email'
                    ),
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      // add more email validation logic
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: 'Enter Password',
                        labelText: 'Password'
                    ),
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      // add more password validation logic
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),

                  ElevatedButton(
                      onPressed: _signup,
                      child: Text('Sign Up')
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}