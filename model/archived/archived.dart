import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/provider.dart';
import 'package:todo/shared/components/components.dart';

class Archived extends StatelessWidget {
  const Archived({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var con = Provider.of<Providerr>(context).arcuiveTasks;
    return tasksBuilder(con: con);
  }
}
