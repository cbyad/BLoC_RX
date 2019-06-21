import 'dart:collection';
import 'package:rx_dart_sample/models/user.dart';
import 'package:rx_dart_sample/utils/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class UserPageBloc {
  final Repository _repository = Repository();

  BehaviorSubject<UnmodifiableListView<User>> _userPageSubject =
      BehaviorSubject<UnmodifiableListView<User>>();

  Stream get users => this._userPageSubject.stream; //Out

  List<User> _users = <User>[];

  UserPageBloc() {
    this._getUsers().then((_) => this
        ._userPageSubject
        .sink // IN
        .add(UnmodifiableListView<User>(this._users)));
  }

  Future<void> _getUsers() async {
    this._users = await _repository.fetchUsers();
  }

  void dispose() {
    this._userPageSubject.sink.close();
    this._userPageSubject.close();
  }
}
