import 'package:currency_rate_calculator/core/utils/validators.dart';
import 'package:currency_rate_calculator/repository/auth_repo.dart';
import 'package:currency_rate_calculator/screens/authentication/login_screen.dart';
import 'package:currency_rate_calculator/widgets/alert_diloge.dart';
import 'package:currency_rate_calculator/widgets/custom_button.dart';
import 'package:currency_rate_calculator/widgets/custom_text_feild.dart';
import 'package:currency_rate_calculator/widgets/show_animation.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  final AuthRepo _authRepo = AuthRepo();

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  //----- button press ---

  Future<void> _onSignUpPressed() async {
    if (isLoading) return;
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        final user = await _authRepo.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (user != null && mounted) {
             await LottieAnimation.showSuccess(
          context: context,
          onCompleted: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
        );
        }
      } on AuthException catch (e) {
        if (mounted) {
          showErrorDialog(context, e.message);
        }
      } catch (e) {
        if (mounted) {
          showErrorDialog(context, "An unexpected error occurred.");
        }
      } finally {
        if (mounted) setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 30,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SignUp",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              CustomTextFeild(
                validator: Validators.name,
                hint: "Name",
                controller: _nameController,
              ),
              CustomTextFeild(
                hint: "Email",
                validator: Validators.email,
                controller: _emailController,
              ),
              CustomTextFeild(
                validator: Validators.password,
                hint: "Password",
                isPassword: true,
                controller: _passwordController,
              ),
              CustomButton(
                onPressed: _onSignUpPressed,
                title: "Sign Up",
                isLoading: isLoading,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You already have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
