import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/analysis_controller.dart';
import '../services/gemini_service.dart';
import '../services/prefs.dart';
import '../theme/tokens.dart';
import '../widgets/app_icons.dart';

enum _Step { source, pasteText, modelPick }

class UploadSheet extends StatefulWidget {
  const UploadSheet({super.key});

  static Future<bool> show(BuildContext context) async {
    final t = Tokens.of(context);
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: t.card,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => const UploadSheet(),
    );
    return result ?? false;
  }

  @override
  State<UploadSheet> createState() => _UploadSheetState();
}

class _UploadSheetState extends State<UploadSheet> {
  _Step _step = _Step.source;
  String _fileName = '';
  Uint8List? _fileBytes;
  String _mimeType = '';
  final _textCtrl = TextEditingController();
  List<GeminiModelInfo> _models = [];
  bool _loadingModels = false;
  String? _modelsError;
  String? _selectedModelId;
  String? _savedToken;

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  String _mimeFromName(String name) {
    final ext = name.split('.').last.toLowerCase();
    return switch (ext) {
      'pdf' => 'application/pdf',
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'gif' => 'image/gif',
      'webp' => 'image/webp',
      'txt' => 'text/plain',
      _ => 'application/octet-stream',
    };
  }

  Future<void> _pickFile(FileType type, {List<String>? extensions}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: extensions,
        withData: true,
      );
      if (result == null || result.files.isEmpty) return;
      final file = result.files.single;
      final bytes = file.bytes;
      if (bytes == null) return;
      setState(() {
        _fileBytes = bytes;
        _fileName = file.name;
        _mimeType = _mimeFromName(file.name);
      });
      await _goToModelPick();
    } catch (_) {}
  }

  Future<void> _goToModelPick() async {
    setState(() {
      _step = _Step.modelPick;
      _loadingModels = true;
      _modelsError = null;
      _models = [];
      _selectedModelId = null;
    });
    final apiKey = await Prefs.getGeminiApiKey();
    if (!mounted) return;
    if (apiKey == null || apiKey.isEmpty) {
      setState(() {
        _loadingModels = false;
        _modelsError = 'No Gemini API token set.\nPlease add one in Settings first.';
      });
      return;
    }
    _savedToken = apiKey;
    try {
      final models = await GeminiService.fetchModels(apiKey);
      if (!mounted) return;
      setState(() {
        _models = models;
        _loadingModels = false;
        _selectedModelId = models.isNotEmpty ? models.first.id : null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loadingModels = false;
        _modelsError = 'Failed to load models:\n$e';
      });
    }
  }

  void _handlePasteTextContinue() {
    final text = _textCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _fileName = 'Pasted text';
      _fileBytes = Uint8List.fromList(utf8.encode(text));
      _mimeType = 'text/plain';
    });
    _goToModelPick();
  }

  void _startAnalysis() {
    if (_selectedModelId == null || _fileBytes == null || _savedToken == null) return;
    final ctrl = context.read<AnalysisController>();
    ctrl.setPending(
      bytes: _fileBytes!,
      fileName: _fileName,
      mimeType: _mimeType,
      modelId: _selectedModelId!,
    );
    ctrl.analyze(_savedToken!);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: switch (_step) {
          _Step.source => _SourceBody(
              onPdf: () =>
                  _pickFile(FileType.custom, extensions: ['pdf', 'txt']),
              onPhoto: () => _pickFile(FileType.image),
              onPaste: () => setState(() => _step = _Step.pasteText),
              onCloud: () => _pickFile(FileType.any),
              onClose: () => Navigator.of(context).pop(false),
            ),
          _Step.pasteText => _PasteBody(
              ctrl: _textCtrl,
              onBack: () => setState(() => _step = _Step.source),
              onClose: () => Navigator.of(context).pop(false),
              onContinue: _handlePasteTextContinue,
            ),
          _Step.modelPick => _ModelPickBody(
              fileName: _fileName,
              loading: _loadingModels,
              error: _modelsError,
              models: _models,
              selectedId: _selectedModelId,
              onModelChange: (id) => setState(() => _selectedModelId = id),
              onBack: () => setState(() => _step = _Step.source),
              onClose: () => Navigator.of(context).pop(false),
              onAnalyze: _startAnalysis,
            ),
        },
      ),
    );
  }
}

// ── Shared header ─────────────────────────────────────────────────────────────

class _SheetHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;
  final VoidCallback? onBack;
  const _SheetHeader({
    required this.title,
    required this.onClose,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: t.hair,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ),
        Row(
          children: [
            if (onBack != null)
              GestureDetector(
                onTap: onBack,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: AppIcons.back(t.ink2, 20),
                ),
              )
            else
              const SizedBox(width: 28),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                  color: t.ink,
                ),
              ),
            ),
            Material(
              color: t.bg,
              borderRadius: BorderRadius.circular(999),
              child: InkWell(
                onTap: onClose,
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  child: AppIcons.close(t.ink2, 18),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Step 1: Source selection ──────────────────────────────────────────────────

class _SourceBody extends StatelessWidget {
  final VoidCallback onPdf;
  final VoidCallback onPhoto;
  final VoidCallback onPaste;
  final VoidCallback onCloud;
  final VoidCallback onClose;
  const _SourceBody({
    required this.onPdf,
    required this.onPhoto,
    required this.onPaste,
    required this.onCloud,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SheetHeader(title: 'Add a contract', onClose: onClose),
          const SizedBox(height: 16),
          _SourceTile(
            iconBuilder: AppIcons.doc,
            title: 'PDF or document',
            sub: 'Files app',
            onTap: onPdf,
          ),
          const SizedBox(height: 8),
          _SourceTile(
            iconBuilder: AppIcons.camera,
            title: 'Photo or scan',
            sub: 'Camera or library',
            onTap: onPhoto,
          ),
          const SizedBox(height: 8),
          _SourceTile(
            iconBuilder: AppIcons.text,
            title: 'Paste text',
            sub: 'From clipboard',
            onTap: onPaste,
          ),
          const SizedBox(height: 8),
          _SourceTile(
            iconBuilder: AppIcons.cloud,
            title: 'Cloud storage',
            sub: 'Drive, Dropbox, iCloud',
            onTap: onCloud,
          ),
        ],
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  final Widget Function(Color, double) iconBuilder;
  final String title;
  final String sub;
  final VoidCallback onTap;
  const _SourceTile({
    required this.iconBuilder,
    required this.title,
    required this.sub,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Material(
      color: t.bg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: t.accentSoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: iconBuilder(t.accent, 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: t.ink,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      sub,
                      style: TextStyle(fontSize: 12, color: t.muted),
                    ),
                  ],
                ),
              ),
              AppIcons.chevR(t.muted, 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Step 2: Paste text ────────────────────────────────────────────────────────

class _PasteBody extends StatelessWidget {
  final TextEditingController ctrl;
  final VoidCallback onBack;
  final VoidCallback onClose;
  final VoidCallback onContinue;
  const _PasteBody({
    required this.ctrl,
    required this.onBack,
    required this.onClose,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SheetHeader(
            title: 'Paste contract',
            onBack: onBack,
            onClose: onClose,
          ),
          const SizedBox(height: 16),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: t.bg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: t.hair),
            ),
            child: TextField(
              controller: ctrl,
              maxLines: null,
              expands: true,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Paste or type your contract text here…',
                hintStyle: TextStyle(color: t.muted, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(14),
              ),
              style: TextStyle(fontSize: 14, color: t.ink, height: 1.5),
            ),
          ),
          const SizedBox(height: 14),
          _ActionButton(label: 'Continue', onTap: onContinue),
        ],
      ),
    );
  }
}

// ── Step 3: Model picker ──────────────────────────────────────────────────────

class _ModelPickBody extends StatelessWidget {
  final String fileName;
  final bool loading;
  final String? error;
  final List<GeminiModelInfo> models;
  final String? selectedId;
  final ValueChanged<String?> onModelChange;
  final VoidCallback onBack;
  final VoidCallback onClose;
  final VoidCallback onAnalyze;
  const _ModelPickBody({
    required this.fileName,
    required this.loading,
    this.error,
    required this.models,
    required this.selectedId,
    required this.onModelChange,
    required this.onBack,
    required this.onClose,
    required this.onAnalyze,
  });

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SheetHeader(
            title: 'Choose model',
            onBack: onBack,
            onClose: onClose,
          ),
          const SizedBox(height: 16),
          // File badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: t.bg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: t.hair),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: t.accentSoft,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  alignment: Alignment.center,
                  child: AppIcons.doc(t.accent, 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    fileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: t.ink,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                AppIcons.check(t.green, 16),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (loading)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: Center(
                child: CircularProgressIndicator(
                  color: t.accent,
                  strokeWidth: 2.5,
                ),
              ),
            )
          else if (error != null)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: t.redSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                error!,
                style: TextStyle(fontSize: 13, color: t.red, height: 1.4),
              ),
            )
          else ...[
            Text(
              'GEMINI MODEL',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: t.muted,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
              decoration: BoxDecoration(
                color: t.bg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: t.hair),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedId,
                  isExpanded: true,
                  dropdownColor: t.card,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: t.ink,
                    fontFamily: 'Ploni',
                  ),
                  onChanged: onModelChange,
                  items: models
                      .map(
                        (m) => DropdownMenuItem(
                          value: m.id,
                          child: Text(m.displayName),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _ActionButton(
              label: 'Analyze contract',
              onTap: selectedId != null ? onAnalyze : null,
            ),
          ],
        ],
      ),
    );
  }
}

// ── Shared button ─────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const _ActionButton({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    final enabled = onTap != null;
    return Material(
      color: enabled ? t.accent : t.hair,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: enabled ? Colors.white : t.muted,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
