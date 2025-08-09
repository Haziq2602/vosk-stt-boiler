 🎤 Flutter VOSK Live Paragraph Speech-to-Text

This Flutter application uses the **VOSK speech recognition engine** to convert spoken words into text **in real time**.  
The transcribed text is displayed **as a clean, readable paragraph** in a full-screen view, with **auto-scrolling** for long text.

***

## 🚀 How It Works
1. User taps the **Start Speaking** button on the home screen.
2. The app starts listening to the microphone using **VOSK**.
3. As you speak, your words are transcribed and added to a **growing paragraph**.
4. The paragraph is displayed on a **full screen**, automatically scrolling if it gets long.
5. When you press **Stop**, transcription ends, and you return to the home screen.

***

## ✨ Features
- 🎯 **Live Speech-to-Text** using the VOSK engine.
- 📝 **Paragraph-style transcription** (no single-word popping).
- 🧹 **Clean output** — no JSON, curly braces, or extra symbols.
- 📜 **Auto-scroll** to always keep the latest text visible.
- 🛑 **Stop button** for easy control.
- 🌐 **Works offline** after downloading the VOSK model.

***

## 📦 Requirements
- Flutter installed on your system.
- `vosk_flutter_2` package added to `pubspec.yaml`.
- A **Vosk model** downloaded and placed in `assets/models/`.

Example for `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/models/vosk-model-small-en-us-0.15/
```

***

## ▶️ Running the App
1. Clone the repository:
   ```bash
   git clone https://github.com//.git
   cd 
   ```
2. Install packages:
   ```bash
   flutter pub get
   ```
3. Download and extract a Vosk model into `assets/models/`.
4. Run the app:
   ```bash
   flutter run
   ```

***

## 📂 Project Structure
```
lib/
 ├─ speech/
 │   └─ vosk_service.dart        # Handles VOSK initialization & transcription
 ├─ ui/
 │   ├─ home_page.dart           # Main screen
 │   └─ live_transcription_screen.dart  # Full-screen transcription display
 └─ main.dart                    # Entry point
assets/
 └─ models/                      # Vosk model files
```

***

## 🛠 Technology Used
- Flutter (Dart)
- VOSK Offline Speech Recognition
- vosk_flutter_2 package

***
