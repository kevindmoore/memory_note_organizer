import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_user.freezed.dart';
part 'todo_user.g.dart';

@freezed
class TodoUser with _$TodoUser {
  const factory TodoUser({
    String? sessionId,
    required String email,
    String? password,
    String? name,
    String? userId
  }
  ) = _TodoUser;
  factory TodoUser.fromJson(Map<String, dynamic> json) =>
      _$TodoUserFromJson(json);

}

class TodoUserBuilder {
  String? _sessionId;
  String? _email;
  String? _password;
  String? _name;
  String? _userId;

  TodoUserBuilder email(String? email) {
    if (email != null) {
      _email = email;
    }
    return this;
  }

  TodoUserBuilder sessionId(String? sessionId) {
    if (sessionId != null) {
      _sessionId = sessionId;
    }
    return this;
  }

  TodoUserBuilder password(String? password) {
    if (password != null) {
      _password = password;
    }
    return this;
  }

  TodoUserBuilder name(String? name) {
    if (name != null) {
      _name = name;
    }
    return this;
  }

  TodoUserBuilder userId(String? userId) {
    if (userId != null) {
      _userId = userId;
    }
    return this;
  }

  TodoUser build() {
    assert(_email != null);
    var user = TodoUser(email: _email!, password: _password);
    if (_sessionId != null) {
      user = user.copyWith(sessionId: _sessionId);
    }
    if (_name != null) {
      user = user.copyWith(name: _name);
    }
    if (_userId != null) {
      user = user.copyWith(userId: _userId);
    }
    return user;
  }
}