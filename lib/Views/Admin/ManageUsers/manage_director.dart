import 'package:flutter/material.dart';
import 'package:flutter_app/Classes/preferances.dart';
import 'package:flutter_app/Classes/strings.dart';
import 'package:flutter_app/Classes/user_data.dart';
import 'package:flutter_app/CustomWidgets/Admin/dialouges_user.dart';
import 'package:flutter_app/CustomWidgets/Admin/director_detail_tile.dart';
import 'package:flutter_app/CustomWidgets/Common/loading_animation.dart';
//import 'package:flutter_app/CustomWidgets/Admin/user_detail.dart';
import 'package:flutter_app/Models/manage_users_model.dart';

class ManageDir extends StatefulWidget {
  final Dialogs dialogs;

  final Function addUser;

  ManageDir(this.addUser, this.dialogs);

  @override
  _ManageDirState createState() => _ManageDirState();
}

class _ManageDirState extends State<ManageDir> {
  ManageUsersModel model;
  Stream<List<UserData>> stream;

  @override
  void initState() {
    model = ManageUsersModel();
    stream = Stream.fromFuture(model.getData());
    //bloc.fetchAllUsers();
    super.initState();
    super.initState();
  }

  @override
  void dispose() {
    //bloc.dispose();
    Preferances.institutes.clear();
    super.dispose();
  }

  void blockUser(UserData user) {
    widget.dialogs.showAlertUserBlock(user);
  }

  void deleteUser(UserData user) {
    widget.dialogs.showAlertUserDelete(user);
  }

  void changeLimit(UserData user) {
    widget.dialogs.showAlertUserChlimit(user);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.87,
          child: StreamBuilder(
            //stream: bloc.allUsers,
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return LoadingAnimationCls();
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length + 1,
                  itemBuilder: (BuildContext conext, int i) {
                    if (i == 0) {
                      return getUpperUI();
                    }
                    return DirDetailTile(snapshot.data[i - 1], blockUser,
                        deleteUser, changeLimit);
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }

  Widget getUpperUI() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
          ),
          InkWell(
              onTap: () {},
              child: Card(
                  child: Container(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Icon(
                        Icons.supervisor_account,
                        color: Colors.redAccent,
                        size: 35.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        Strings.mngDir,
                        style: TextStyle(
                            color: Colors.tealAccent,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w200),
                      )
                    ],
                  ),
                ),
              ))),
        ],
      ),
    );
  }
}
