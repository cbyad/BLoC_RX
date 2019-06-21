import 'package:flutter/material.dart';
import 'package:rx_dart_sample/blocs/user_page_bloc.dart';
import 'package:rx_dart_sample/models/user.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserPageBloc _bloc = UserPageBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BLoc-RxDart demo")),
      body: Center(
        child: StreamBuilder<List<User>>(
          stream: _bloc.users,
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Connexion Error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Center(child: Text("You have no users to display"));
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => ListTile(
                      leading: Icon(Icons.person),
                      title: Text("${snapshot.data[index].username}"),
                    ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
