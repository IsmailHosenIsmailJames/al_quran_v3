import "package:al_quran_v3/src/core/auth/auth_service.dart";
import "package:al_quran_v3/src/screen/auth/signup_screen.dart";
import "package:al_quran_v3/src/theme/controller/theme_cubit.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gap/gap.dart";
import "package:google_sign_in/google_sign_in.dart";

import "../../utils/email_validity_checker.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSigningIn = false;

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isSigningIn = true;
    });

    final UserCredential? userCredential =
        await _authService.signInWithGoogle();

    if (mounted) {
      setState(() {
        _isSigningIn = false;
      });

      if (userCredential != null) {
        // Navigate to home screen or show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Signed in as ${userCredential.user?.displayName}"),
          ),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Google Sign-In failed.")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>().state;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(color: themeCubit.primary),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Welcome Back!",
                    style: textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: themeCubit.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(8),
                  Text(
                    "Login to your account",
                    style: textTheme.titleMedium?.copyWith(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(40),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!isValidEmail(value)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: themeCubit.primary),
                      ),
                    ),
                  ),
                  const Gap(20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Implement email/password login
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Login"),
                  ),
                  const Gap(20),
                  const Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("OR", style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),
                  const Gap(20),
                  if (GoogleSignIn.instance.supportsAuthenticate())
                    _isSigningIn
                        ? const Center(child: CircularProgressIndicator())
                        : OutlinedButton.icon(
                          onPressed: _signInWithGoogle,
                          icon: SvgPicture.asset(
                            "assets/img/gmail.svg",
                            height: 24,
                            width: 24,
                          ),
                          label: const Text("Sign in with Google"),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: themeCubit.primary,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
