import 'package:flutter/material.dart';
import '../custom_button.dart';
import '../custom_input.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool loading;
  final VoidCallback onRegister;

  const RegisterForm({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    this.loading = false,
    required this.onRegister,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInput(
          controller: nameController,
          label: "Nome completo",
        ),
        const SizedBox(height: 16),
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
        CustomInput(
          controller: confirmPasswordController,
          label: "Confirme a senha",
          obscureText: true,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: loading ? "Cadastrando..." : "Cadastrar",
            onPressed: loading ? null : onRegister,
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