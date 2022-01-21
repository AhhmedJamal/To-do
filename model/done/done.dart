import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/provider.dart';
import 'package:todo/shared/components/components.dart';

class Done extends StatelessWidget {
  const Done({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var con = Provider.of<Providerr>(context).doneTasks;
    return tasksBuilder(con: con);
  }
}
