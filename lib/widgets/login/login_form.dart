import 'package:flutter/material.dart';
import '../custom_button.dart';
import '../custom_input.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool loading;
  final VoidCallback onLogin;

  const LoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    this.loading = false,
    required this.onLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInput(
          controller: emailController,
          label: "Email",
        ),
        const SizedBox(height: 16),
        CustomInput(
          controller: passwordController,
          label: "Senha",
          obscureText: true,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: loading ? "Entrando..." : "Entrar",
            onPressed: loading ? null : onLogin,
            loading: loading,
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: "Google",
            outlined: true,
            icon: Icons.g_mobiledata,
            onPressed: loading ? null : () {},
          ),
        ),
      ],
    );
  }
} 