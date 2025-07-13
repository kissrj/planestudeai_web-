import 'package:flutter/material.dart';
import '../../widgets/dashboard_layout.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // Mock user data
  Map<String, dynamic> userProfile = {
    'full_name': 'João da Silva',
    'email': 'joao@email.com',
    'created_at': DateTime(2023, 1, 15),
    'plan': 'Básico',
    'status': 'Ativo',
  };

  final _profileFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: userProfile['full_name']);
    _emailController = TextEditingController(text: userProfile['email']);
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_profileFormKey.currentState!.validate()) {
      setState(() {
        userProfile['full_name'] = _nameController.text;
        userProfile['email'] = _emailController.text;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados atualizados com sucesso!')),
      );
    }
  }

  void _changePassword() {
    if (_passwordFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Senha alterada com sucesso!')),
      );
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userName = userProfile['full_name'] ?? 'Usuário';
    final userEmail = userProfile['email'] ?? '';
    final createdAt = userProfile['created_at'] as DateTime?;
    final plan = userProfile['plan'] ?? 'Básico';
    final status = userProfile['status'] ?? 'Ativo';

    return DashboardScaffold(
      title: 'Minha Conta',
      selectedIndex: 7,
      onMenuTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushNamed('/dashboard');
            break;
          case 1:
            Navigator.of(context).pushNamed('/upload-edital');
            break;
          case 2:
            Navigator.of(context).pushNamed('/configure-schedule');
            break;
          case 3:
            Navigator.of(context).pushNamed('/study-plan');
            break;
          case 4:
            Navigator.of(context).pushNamed('/revisao-flashcards');
            break;
          case 5:
            Navigator.of(context).pushNamed('/pomodoro');
            break;
          case 6:
            Navigator.of(context).pushNamed('/progresso');
            break;
          case 7:
            Navigator.of(context).pushNamed('/minha-conta');
            break;
          default:
            Navigator.of(context).pushNamed('/dashboard');
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Minha Conta',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 16,
                runSpacing: 16,
                children: [
                  // Perfil
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 240, maxWidth: 360),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0.5,
                      margin: const EdgeInsets.only(right: 16),
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width < 500 ? 12 : 20),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.blue[800],
                              child: Text(
                                userName.split(' ').map((n) => n[0]).join('').toUpperCase(),
                                style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18), overflow: TextOverflow.ellipsis),
                            Text(userEmail, style: const TextStyle(color: Colors.grey), overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue[800],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('Plano Básico', style: TextStyle(color: Colors.white, fontSize: 13)),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Conta criada em ${createdAt != null ? '${createdAt.day.toString().padLeft(2, '0')}/${createdAt.month.toString().padLeft(2, '0')}/${createdAt.year}' : 'N/A'}',
                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Formulários e assinatura
                  Container(
                    width: 400,
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Column(
                      children: [
                        // Informações pessoais
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0.5,
                          margin: const EdgeInsets.only(bottom: 24),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.person, size: 22),
                                    SizedBox(width: 8),
                                    Text('Informações Pessoais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Form(
                                  key: _profileFormKey,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: _nameController,
                                              decoration: const InputDecoration(labelText: 'Nome completo'),
                                              validator: (v) => v == null || v.isEmpty ? 'Informe seu nome' : null,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _emailController,
                                              decoration: const InputDecoration(labelText: 'Email'),
                                              validator: (v) => v == null || v.isEmpty ? 'Informe seu email' : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: _saveProfile,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue[800],
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            ),
                                            child: const Text('Salvar alterações'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Alterar senha
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0.5,
                          margin: const EdgeInsets.only(bottom: 24),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.shield, size: 22),
                                    SizedBox(width: 8),
                                    Text('Alterar Senha', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Form(
                                  key: _passwordFormKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _currentPasswordController,
                                        decoration: const InputDecoration(labelText: 'Senha atual'),
                                        obscureText: true,
                                        validator: (v) => v == null || v.isEmpty ? 'Informe a senha atual' : null,
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: _newPasswordController,
                                              decoration: const InputDecoration(labelText: 'Nova senha'),
                                              obscureText: true,
                                              validator: (v) => v == null || v.isEmpty ? 'Informe a nova senha' : null,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _confirmPasswordController,
                                              decoration: const InputDecoration(labelText: 'Confirme a nova senha'),
                                              obscureText: true,
                                              validator: (v) => v != _newPasswordController.text ? 'Senhas não conferem' : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: _changePassword,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue[800],
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            ),
                                            child: const Text('Alterar senha'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Detalhes da assinatura
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.credit_card, size: 22),
                                    SizedBox(width: 8),
                                    Text('Detalhes da Assinatura', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Plano $plan', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        const Text('Funcionalidades básicas incluídas', style: TextStyle(fontSize: 13, color: Colors.grey)),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.green),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(status, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                                const Divider(height: 32),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        child: const Text('Fazer upgrade do plano'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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