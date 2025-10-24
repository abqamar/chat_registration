import 'package:flutter/material.dart';

/// Who sent the message in the chat transcript
enum ChatSender { user, bot }

/// Represents a message in the transcript
class ChatMessage {
  final String id;
  final ChatSender sender;
  final String text;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
  });
}

/// Types of inputs the step can request
enum ChatInputType {
  text,
  number,
  name,
  lastName,
  email,
  dob,
  idNumber,
  custom,
}

/// A single step in the chat-based registration flow
class ChatStep {
  final String id; // storage key in result map
  final String prompt; // bot message shown before input
  final ChatInputType type;
  final String? hintText;
  final String? initialValue;

  /// Optional custom validator. Return null if valid, or an error string.
  final String? Function(String value)? validator;

  /// Optional custom input decoration override for this step
  final InputDecoration? inputDecoration;

  /// Optional custom keyboard type override
  final TextInputType? keyboardType;

  /// Called when the user submits this step (before moving next)
  final Future<void> Function(String value)? onSubmitted;

  const ChatStep({
    required this.id,
    required this.prompt,
    required this.type,
    this.hintText,
    this.initialValue,
    this.validator,
    this.inputDecoration,
    this.keyboardType,
    this.onSubmitted,
  });
}
