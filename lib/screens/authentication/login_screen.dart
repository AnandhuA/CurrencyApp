import 'package:currency_rate_calculator/core/utils/validators.dart';
import 'package:currency_rate_calculator/repository/auth_repo.dart';
import 'package:currency_rate_calculator/repository/user_prefs_repo.dart';
import 'package:currency_rate_calculator/screens/authentication/sign_up_screen.dart';
import 'package:currency_rate_calculator/screens/home_screen.dart';
import 'package:currency_rate_calculator/widgets/alert_diloge.dart';
import 'package:currency_rate_calculator/widgets/custom_button.dart';
import 'package:currency_rate_calculator/widgets/custom_text_feild.dart';
import 'package:currency_rate_calculator/widgets/show_animation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthRepo _auth = AuthRepo();

  //----- button press ---

  Future<void> _onLoginPressed() async {
    if (isLoading) return;
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        final user = await _auth.login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (user != null) {
          if (context.mounted) {
            await LottieAnimation.showSuccess(
              context: context,
              onCompleted: () async {
                await UserPrefsRepo.setLoggedIn(true);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
              },
            );
          }
        }
      } on AuthException catch (e) {
        if (context.mounted) {
          showErrorDialog(context, e.message);
        }
      } finally {
        if (mounted) setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasPrimaryFocus == false &&
            FocusScope.of(context).focusedChild != null) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 30,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
      
                CustomTextFeild(
                  validator: Validators.email,
                  hint: "Email",
                  controller: _emailController,
                ),
                CustomTextFeild(
                  validator: Validators.password,
                  hint: "Password",
                  isPassword: true,
                  controller: _passwordController,
                ),
                CustomButton(
                  onPressed: _onLoginPressed,
                  title: "Login",
                  isLoading: isLoading,
                ),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (_) => SignUpScreen()));
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: const Text(
                        'Sign Up',
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
      ),
    );
  }
}
