import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/provider.dart';
import 'layout/home_layout.dart';
import 'shared/components/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Providerr()..createDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo',
        theme: ThemeData(
          primarySwatch: kOrang,
          primaryColor: kgrey,
        ),
        home:  HomeLayout(),
      ),
    );
  }
}
