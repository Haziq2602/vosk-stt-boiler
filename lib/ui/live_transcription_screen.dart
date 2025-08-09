import 'package:flutter/material.dart';

class LiveTranscriptionScreen extends StatefulWidget {
  final Stream<String> textStream;
  final VoidCallback onStop;

  const LiveTranscriptionScreen({
    super.key,
    required this.textStream,
    required this.onStop,
  });

  @override
  State<LiveTranscriptionScreen> createState() =>
      _LiveTranscriptionScreenState();
}

class _LiveTranscriptionScreenState
    extends State<LiveTranscriptionScreen> {
  String _text = "";
  final ScrollController _scrollController =
      ScrollController();

  @override
  void initState() {
    super.initState();
    widget.textStream.listen((newText) {
      setState(() {
        _text = newText;
      });
      // Auto-scroll to bottom on new text
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Transcription"),
        actions: [
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: widget.onStop,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Text(
            _text,
            style: const TextStyle(
              fontSize: 20,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
