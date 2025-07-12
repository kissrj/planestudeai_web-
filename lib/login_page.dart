import 'package:flutter/material.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_input.dart';
import 'widgets/login/login_form.dart';
import 'widgets/login/register_form.dart';
import 'widgets/header.dart';

class LoginPage extends StatefulWidget {
  final int initialTab;
  const LoginPage({Key? key, this.initialTab = 0}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Controllers para os campos de login
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  // Controllers para os campos de cadastro
  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController = TextEditingController();
  final TextEditingController registerConfirmPasswordController = TextEditingController();

  // Form keys
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  // Loading states
  bool isLoginLoading = false;
  bool isRegisterLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
  }

  @override
  void dispose() {
    _tabController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
  }

  void _handleLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;
    setState(() => isLoginLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // Simula requisição
    setState(() => isLoginLoading = false);
    _showSnackBar("Login realizado com sucesso!");
  }

  void _handleRegister() async {
    if (!_registerFormKey.currentState!.validate()) return;
    setState(() => isRegisterLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // Simula requisição
    setState(() => isRegisterLoading = false);
    _showSnackBar("Cadastro realizado com sucesso!");
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      body: Column(
        children: [
          const Header(showLogin: false, showSignup: false, showHome: true),
          Expanded(
            child: Row(
              children: [
                if (isLargeScreen)
                  Expanded(
                    child: Container(
                      color: Colors.blue.shade800,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Bem-vindo(a) ao PlanEstudeAI",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Comece a planejar seu sucesso nos concursos!",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 32),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                "https://images.unsplash.com/photo-1518133835878-5a93cc3f89e5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
                                width: 400,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(32),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "PlanEstudeAI",
                              style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              "Acesse sua conta",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Comece a planejar seu sucesso nos concursos!",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 32),
                            TabBar(
                              controller: _tabController,
                              tabs: const [
                                Tab(text: "Login"),
                                Tab(text: "Cadastro"),
                              ],
                              labelColor: Colors.blue,
                              unselectedLabelColor: Colors.black54,
                              indicatorColor: Colors.blue,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 420,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  // Formulário de Login
                                  Form(
                                    key: _loginFormKey,
                                    child: LoginForm(
                                      emailController: loginEmailController,
                                      passwordController: loginPasswordController,
                                      loading: isLoginLoading,
                                      onLogin: _handleLogin,
                                    ),
                                  ),
                                  // Formulário de Cadastro
                                  Form(
                                    key: _registerFormKey,
                                    child: RegisterForm(
                                      nameController: registerNameController,
                                      emailController: registerEmailController,
                                      passwordController: registerPasswordController,
                                      confirmPasswordController: registerConfirmPasswordController,
                                      loading: isRegisterLoading,
                                      onRegister: _handleRegister,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text.rich(
                              TextSpan(
                                text: "Ao continuar, você concorda com nossos ",
                                children: [
                                  TextSpan(
                                    text: "Termos de Serviço",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: " e "),
                                  TextSpan(
                                    text: "Política de Privacidade",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: "."),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 