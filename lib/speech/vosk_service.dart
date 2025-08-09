import 'dart:async';
import 'dart:convert';
import 'package:vosk_flutter_2/vosk_flutter_2.dart';

class VoskService {
  final String assetModelPath;

  late final Model _model;
  Recognizer? _recognizer;
  SpeechService? _speechService;

  final _textController =
      StreamController<String>.broadcast();
  final List<String> _paragraphBuffer = [];

  Stream<String> get textStream => _textController.stream;

  VoskService(this.assetModelPath);

  Future<void> init() async {
    final modelPath = await ModelLoader().loadFromAssets(
      assetModelPath,
    );
    _model = await VoskFlutterPlugin.instance().createModel(
      modelPath,
    );
    _recognizer = await VoskFlutterPlugin.instance()
        .createRecognizer(model: _model, sampleRate: 16000);
    _speechService = await VoskFlutterPlugin.instance()
        .initSpeechService(_recognizer!);

    // ✅ Only final results after Vosk confirms
    _speechService!.onResult().listen((finalJson) {
      final finalText = _extractTextFromJson(finalJson);
      if (finalText.isNotEmpty) {
        _paragraphBuffer.add(finalText);
        _textController.add(_paragraphBuffer.join(" "));
      }
    });
  }

  Future<void> start() async {
    if (_speechService == null) await init();
    _paragraphBuffer.clear();
    await _speechService?.start();
  }

  Future<void> stop() async {
    await _speechService?.stop();
  }

  void dispose() {
    _speechService?.dispose();
    _recognizer?.dispose();
    _textController.close();
  }

  // Clean Vosk JSON output → Only extract spoken words
  String _extractTextFromJson(String jsonStr) {
    try {
      final data = json.decode(jsonStr);
      if (data is Map && data.containsKey("text")) {
        return data["text"].toString().trim();
      }
      return jsonStr; // fallback if it's plain string
    } catch (_) {
      return jsonStr.trim();
    }
  }
}
