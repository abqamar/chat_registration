## chat_registration
A chat-style registration flow for Flutter apps — makes onboarding feel conversational, like a messaging app.

## 📦 Installation
Add this line to your pubspec.yaml:
```yaml
dependencies:
  chat_registration: ^0.1.0
```
Then run:
```hash
flutter pub get
```

Import it:
```dart
import 'package:chat_registration/chat_registration.dart';
```

## 🚀 Usage Example
```dart
ChatRegistrationFlow(
steps: [
ChatStep(id: 'mobile', prompt: 'Enter your mobile number', type: ChatInputType.number),
ChatStep(id: 'firstName', prompt: 'Enter your name', type: ChatInputType.name),
ChatStep(id: 'lastName', prompt: 'Enter your last name', type: ChatInputType.lastName),
ChatStep(id: 'dob', prompt: 'Enter your date of birth', type: ChatInputType.dob),
ChatStep(id: 'email', prompt: 'Enter your email address', type: ChatInputType.email),
ChatStep(id: 'idNumber', prompt: 'Enter your ID number', type: ChatInputType.idNumber),
],
onCompleted: (result) {
print('Registration complete: $result');
},
theme: ChatRegTheme(
backgroundColor: Colors.white,
botBubbleColor: const Color(0xFFE3F2FD),
userBubbleColor: const Color(0xFFC8E6C9),
sendIcon: const Icon(Icons.send),
),
)
```

## 🎨 Customization

- ChatRegTheme lets you customize colors, fonts, button styles, delays, padding, and more.
- Supports typing indicators, per-step validation, and automatic input type switching (text, number, date picker, etc.).
- Works in both LTR and RTL.

## 📁 Folder Structure

chat_registration/
├── lib/
│ ├── chat_registration.dart
│ └── src/
│ ├── flow.dart
│ ├── models.dart
│ ├── theme.dart
│ └── widgets/
│ ├── chat_bubble.dart
│ ├── typing_indicator.dart
│ └── input_bar.dart
├── example/
│ └── lib/main.dart
├── CHANGELOG.md
├── LICENSE
└── README.md



