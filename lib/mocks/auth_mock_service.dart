import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:flutter_chatgpt/models/chat_user.dart';
import 'package:flutter_chatgpt/services/auth_service.dart';

class AuthMockService implements AuthService {
  static const _defaultUser = ChatUser(
    id: '123',
    name: 'Marcos',
    email: 'marcos@teste.com.br',
    imageUrl: 'assets/images/avatar.png',
  );

  static const _defaultBot = ChatUser(
    id: '456',
    name: 'Chat Gpt',
    email: 'chat@teste.com.br',
    imageUrl: 'assets/images/avatar_chat.png',
  );

  static final Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser,
  };

  static ChatUser? _currentUser;
  static ChatUser? _currentBot;

  static MultiStreamController<ChatUser?>? _controller;

  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  @override
  ChatUser? get currentUser {
    _currentUser = _defaultUser;
    return _currentUser;
  }

  @override
  ChatUser? get currentBot {
    _currentBot = _defaultBot;
    return _currentBot;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets/images/avatar.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
