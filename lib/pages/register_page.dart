import 'package:flutter/material.dart';
import 'package:flutter1/services/auth/auth_service.dart';
import 'package:flutter1/components/my_button.dart';
import 'package:flutter1/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final void Function()? onTap;
  void register(final context) async{
    final authService = AuthService();

    if (_passwordController.text == _confirmPasswordController.text){
      try {
        await authService.signUpWithEmailPassword(_emailController.text, _passwordController.text);
      }
      catch (e) {
         showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ));
      }
    }

    else {
       showDialog(context: context, builder: (context) => const AlertDialog(
        title: Text("Passwords don't match!"),
      ));
    }
  }
  RegisterPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Let's create an account for you!",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            const SizedBox(
              height: 50,
            ),
            MyTextField(
              textHint: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              textHint: "Password",
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              textHint: "Confirm Password",
              obscureText: true,
              controller: _confirmPasswordController,
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              text: 'Register',
              onTap: () => register(context),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already a member? ", style: TextStyle(
                  color: Theme.of(context).colorScheme.primary
                ),),
                GestureDetector(onTap: onTap,child: Text("Login now", style: TextStyle(fontWeight: FontWeight.bold,  color: Theme.of(context).colorScheme.primary),))
              ],
            )
          ],
        ),
      ),
    );
  }
}