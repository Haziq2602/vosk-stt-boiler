import 'package:flutter/material.dart';
import '../speech/vosk_service.dart';
import 'live_transcription_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final VoskService _voskService;

  @override
  void initState() {
    super.initState();
    _voskService = VoskService(
      'assets/models/vosk-model-small-en-us-0.15.zip',
    );
  }

  @override
  void dispose() {
    _voskService.dispose();
    super.dispose();
  }

  void _startTranscription() async {
    await _voskService.start();
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LiveTranscriptionScreen(
          textStream: _voskService.textStream,
          onStop: () async {
            await _voskService.stop();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VOSK Paragraph STT"),
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.mic),
          label: const Text("Start Speaking"),
          onPressed: _startTranscription,
        ),
      ),
    );
  }
}
