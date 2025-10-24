import 'package:flutter/material.dart';
import 'package:chat_registration/chat_registration.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Registration Demo',
      theme: ThemeData(
          useMaterial3: true, colorSchemeSeed: const Color(0xFF176163)),
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatelessWidget {
  const DemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = <ChatStep>[
      ChatStep(
        id: 'mobile',
        prompt: 'Enter your mobile number',
        type: ChatInputType.number,
        hintText: '05XXXXXXXX',
        validator: (v) {
          if (v.trim().isEmpty) return 'Mobile is required';
          final ok =
              RegExp(r'^(?:\+971|00971|0)?5[0-9]{8}$').hasMatch(v.trim());
          return ok ? null : 'Enter a valid UAE mobile number';
        },
      ),
      const ChatStep(
        id: 'firstName',
        prompt: 'Enter your name',
        type: ChatInputType.name,
        hintText: 'First Name',
      ),
      const ChatStep(
        id: 'lastName',
        prompt: 'Enter your last name',
        type: ChatInputType.lastName,
        hintText: 'Last Name',
      ),
      const ChatStep(
        id: 'dob',
        prompt: 'Enter your date of birth',
        type: ChatInputType.dob,
        hintText: 'Tap to pick a date',
      ),
      ChatStep(
        id: 'email',
        prompt: 'Enter your email address',
        type: ChatInputType.email,
        hintText: 'you@example.com',
      ),
      const ChatStep(
        id: 'idNumber',
        prompt: 'Enter your ID number',
        type: ChatInputType.idNumber,
        hintText: '784-XXXX-XXXXXXX-X',
      ),
    ];

    final theme = ChatRegTheme(
      backgroundColor: const Color(0xFFFEF9F1),
      botBubbleColor: const Color(0xFFE8F5E9),
      userBubbleColor: const Color(0xFFE3F2FD),
      sendIcon: const Icon(Icons.send),
      typingDelay: const Duration(milliseconds: 850),
      stepDelay: const Duration(milliseconds: 420),
      bubbleRadius: BorderRadius.circular(18),
      inputDecoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.white,
      ),
      sendButtonStyle: ElevatedButton.styleFrom(
          minimumSize: const Size(52, 52), shape: const CircleBorder()),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Chat Registration Demo')),
      body: ChatRegistrationFlow(
        steps: steps,
        theme: theme,
        isRtl: false, // set true for Arabic layout
        onAnswer: (id, value) {
          debugPrint('Answered: $id -> $value');
        },
        onCompleted: (result) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Done!'),
              content: Text(
                  result.entries.map((e) => '${e.key}: ${e.value}').join('\n')),
            ),
          );
        },
      ),
    );
  }
}
