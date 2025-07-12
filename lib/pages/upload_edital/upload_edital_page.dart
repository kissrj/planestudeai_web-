import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../widgets/dashboard_layout.dart';

class UploadEditalPage extends StatefulWidget {
  const UploadEditalPage({super.key});

  @override
  State<UploadEditalPage> createState() => _UploadEditalPageState();
}

class _UploadEditalPageState extends State<UploadEditalPage> {
  int selectedTab = 0; // 0 = Upload PDF, 1 = Colar Texto
  String? fileName;
  bool isUploading = false;
  String? pastedText;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        fileName = result.files.single.name;
      });
    }
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              onTap: () => setState(() => selectedTab = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selectedTab == 0 ? Colors.white : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Text(
                  'Upload PDF',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: selectedTab == 0 ? const Color(0xFF1A237E) : const Color(0xFF7B809A),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              onTap: () => setState(() => selectedTab = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selectedTab == 1 ? Colors.white : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  'Colar Texto',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: selectedTab == 1 ? const Color(0xFF1A237E) : const Color(0xFF7B809A),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 36, 40, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fazer upload do PDF do edital',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xFF222B45),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Nossa IA analisará automaticamente o PDF para extrair as disciplinas e conteúdo programático.',
              style: TextStyle(
                color: Color(0xFF7B809A),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 28),
            // Área de upload
            DottedBorder(
              color: const Color(0xFFCBD5E1),
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              dashPattern: const [7, 6],
              strokeWidth: 1.5,
              child: GestureDetector(
                onTap: isUploading ? null : pickFile,
                child: Container(
                  width: double.infinity,
                  height: 180,
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload_rounded, size: 48, color: const Color(0xFFB0B8C1)),
                      const SizedBox(height: 14),
                      const Text(
                        'Clique para fazer upload ou arraste o arquivo',
                        style: TextStyle(fontSize: 16, color: Color(0xFF7B809A), fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Apenas arquivos PDF (máx. 10MB)',
                        style: TextStyle(fontSize: 13, color: Color(0xFFB0B8C1)),
                      ),
                      if (fileName != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Selecionado: $fileName',
                          style: const TextStyle(fontSize: 14, color: Color(0xFF1A237E), fontWeight: FontWeight.w600),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: (fileName != null && !isUploading) ? () {} : null,
                  icon: const Icon(Icons.description_outlined, color: Color(0xFF1A237E)),
                  label: const Text('Analisar PDF com IA'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE3E8F7),
                    foregroundColor: const Color(0xFF1A237E),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasteCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 36, 40, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Colar texto do edital',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xFF222B45),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Cole o edital completo, incluindo o conteúdo programático, para análise automática.',
              style: TextStyle(
                color: Color(0xFF7B809A),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 28),
            TextField(
              minLines: 8,
              maxLines: 16,
              decoration: InputDecoration(
                hintText: 'Cole aqui o texto do edital...'
              ),
              onChanged: (value) => setState(() => pastedText = value),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: (pastedText != null && pastedText!.trim().isNotEmpty && !isUploading) ? () {} : null,
                  icon: const Icon(Icons.description_outlined, color: Color(0xFF1A237E)),
                  label: const Text('Analisar Texto com IA'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE3E8F7),
                    foregroundColor: const Color(0xFF1A237E),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(top: 32),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 36, 40, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dicas para obter melhores resultados',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xFF222B45),
              ),
            ),
            const SizedBox(height: 18),
            _tip('Para PDFs: Certifique-se de que o arquivo não está protegido por senha.'),
            _tip('Para texto: Cole o edital completo, incluindo o conteúdo programático detalhado.'),
            _tip('Evite imagens ou scans de baixa qualidade.'),
            _tip('O tamanho máximo do arquivo PDF é 10MB.'),
          ],
        ),
      ),
    );
  }

  Widget _tip(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 17, color: Color(0xFF7B809A))),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, color: Color(0xFF7B809A)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      title: 'Colar Edital',
      selectedIndex: 1,
      onMenuTap: (index) {
        // Reutiliza a navegação do dashboard
        Navigator.of(context).pushNamed(_routeForIndex(index));
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTabs(),
              if (selectedTab == 0) _buildUploadCard(),
              if (selectedTab == 1) _buildPasteCard(),
            ],
          ),
        ),
      ),
    );
  }

  String _routeForIndex(int index) {
    switch (index) {
      case 0:
        return '/dashboard';
      case 1:
        return '/upload-edital';
      case 2:
        return '/configure-schedule';
      case 3:
        return '/study-plan';
      case 4:
        return '/review-flashcards';
      case 5:
        return '/pomodoro';
      case 6:
        return '/progresso';
      case 7:
        return '/minha-conta';
      default:
        return '/dashboard';
    }
  }
} 