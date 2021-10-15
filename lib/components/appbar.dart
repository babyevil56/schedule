import 'package:flutter/material.dart';
import 'package:schedule/screen/home.dart';

class StaticAppBar extends StatefulWidget implements PreferredSizeWidget {
  StaticAppBar() : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  _StaticAppBar createState() => _StaticAppBar();
}

class _StaticAppBar extends State<StaticAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amber,
      title: Container(
        child: Text(
          "To-Do-List",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class RedirectAppBar extends StatefulWidget implements PreferredSizeWidget {
  RedirectAppBar({required this.newSchedule, required this.onPress})
      : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;
  bool newSchedule;
  Function onPress;

  @override
  _RedirectAppBar createState() => _RedirectAppBar();
}

class _RedirectAppBar extends State<RedirectAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amber,
      title: Text(
        ((widget.newSchedule) ? "Add new To-Do-List" : "Edit To-Do-List"),
        style: TextStyle(color: Colors.black),
      ),
      elevation: 0.0,
      leading: new IconButton(
        icon: new Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () => widget.onPress()
      ),
    );
  }
}
