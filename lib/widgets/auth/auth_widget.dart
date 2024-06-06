import 'package:anilist/widgets/main_screen/main_screen_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:anilist/Theme/app_colors.dart';

class AuthWidget extends StatefulWidget {
  AuthWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthWidget();
  }
}

class _AuthWidget extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          _HeaderWigdet(),
        ],
      ),
    );
  }
}

class _HeaderWigdet extends StatelessWidget {
  const _HeaderWigdet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Login",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 60,
          ),
          FormWidget(),
        ],
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});
  @override
  State<StatefulWidget> createState() {
    return _FormWigdet();
  }
}

class _FormWigdet extends State<FormWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? errorText = null;

  void _auth() {
    final email = _emailController.text;
    final password = _passwordController.text;
    if (email == "admin" && password == "admin") {
      errorText = null;

      // Так можно но это неудобно
      // navigator.push(
      //   MaterialPageRoute(builder: (context) => const MainScreenWidget()),

      // );

      Navigator.of(context).pushReplacementNamed('/main_screen');
    } else {
      errorText = "Не верный логин или пароль";
    }
    setState(() {});
  }

  void _forgotPassword() {}

  void _notRegistered() {
    Navigator.of(context).pushReplacementNamed('/registration_widget');
  }

  @override
  Widget build(BuildContext context) {
    final errorText = this.errorText;
    return Column(
      children: [
        if (errorText != null) ...[
          Text(
            errorText,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            filled: true,
            fillColor: AppColors.inputColor,
            hintText: 'Email',
            border: InputBorder.none,
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
            fillColor: AppColors.inputColor,
            hintText: 'Password',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: _auth,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 13, 157, 235),
              foregroundColor: Colors.white),
          child: const Text("Login"),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: _forgotPassword,
          style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 172, 193, 210)),
          child: const Text("Forgot password?"),
        ),
        const SizedBox(
          height: 30,
        ),
        TextButton(
            onPressed: _notRegistered,
            child: const Text("Not registered? Create an account"))
      ],
    );
  }
}
