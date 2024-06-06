import "package:anilist/widgets/auth/auth_widget.dart";
import "package:flutter/material.dart";

class RegistrationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationWidget();
  }
}

class _RegistrationWidget extends State<RegistrationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        _HeaderWigdet(),
      ],
    ));
  }
}

class _HeaderWigdet extends StatelessWidget {
  _HeaderWigdet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Sign up to Anilist",
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 60,
          ),
          RegistrationFormWidget(),
        ],
      ),
    );
  }
}

class RegistrationFormWidget extends StatefulWidget {
  RegistrationFormWidget({super.key});
  @override
  State<StatefulWidget> createState() {
    return _RegistrationFormWidget();
  }
}

class _RegistrationFormWidget extends State<RegistrationFormWidget> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _auth() {
    Navigator.of(context).pushReplacementNamed('/main_screen');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 23, 22, 34),
              border: InputBorder.none,
              hintText: 'Email',
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 23, 22, 34),
              border: InputBorder.none,
              hintText: 'Username',
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 23, 22, 34),
              border: InputBorder.none,
              hintText: 'Password',
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 23, 22, 34),
              border: InputBorder.none,
              hintText: 'Confirm password',
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Checkbox(
                value: false,
                onChanged: (newValue) {},
              ),
              const Text("You agree to our terms of service")
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(onPressed: _auth, child: const Text("Sign Up"))
        ],
      ),
    );
  }
}
