import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/archived/archived.dart';
import 'package:todo/model/done/done.dart';
import 'package:todo/model/new/new.dart';
import 'package:todo/provider/provider.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/components/constants.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  List<Widget> titles = [
    const Text('NewTasks', style: TextStyle(fontSize: kPadding)),
    const Text('DoneTasks', style: TextStyle(fontSize: kPadding)),
    const Text('Archive tasks', style: TextStyle(fontSize: kPadding)),
  ];
  List<Widget> screens = [
    const New(),
    const Done(),
    const Archived(),
  ];
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var con = Provider.of<Providerr>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: titles[con.currnIndex]),
      body: screens[con.currnIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (con.isBottom) {
            if (formKey.currentState!.validate()) {
              con.insrtDatabase(
                date: dateController.text,
                title: titleController.text,
                time: timeController.text,
                context: context,
              );
            }
          } else {
            scaffoldKey.currentState!
                .showBottomSheet(
                  (context) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: kPadding),
                    padding: const EdgeInsetsDirectional.only(
                        bottom: kPadding,
                        start: kPadding,
                        end: kPadding,
                        top: kPadding / 3),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(blurRadius: 5, color: kgrey.shade300)
                      ],
                      color: kWhite,
                    ),
                    height: 300,
                    child: SizedBox(
                      width: double.infinity,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: kPadding,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: kgrey,
                                  borderRadius:
                                      BorderRadius.circular(kPadding / 2)),
                            ),
                            textField(
                              controller: titleController,
                              inputType: TextInputType.text,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'title must not be empty';
                                }
                                return null;
                              },
                              perfix: Icons.title,
                              label: 'Task Title',
                              onTap: () {},
                            ),
                            textField(
                              controller: timeController,
                              inputType: TextInputType.datetime,
                              perfix: Icons.watch_later_outlined,
                              label: 'Tasks Time',
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  timeController.text =
                                      value!.format(context).toString();
                                });
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'time must not be empty';
                                }
                                return null;
                              },
                            ),
                            textField(
                              controller: dateController,
                              inputType: TextInputType.datetime,
                              perfix: Icons.date_range,
                              label: 'enter Date',
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2021-12-01'),
                                ).then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                });
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'date must not be empty';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .closed
                .then((value) {
              con.changeBottom(
                isShow: false,
                icon: Icons.edit,
              );
            });
            con.changeBottom(
              isShow: true,
              icon: Icons.add,
            );
          }
        },
        child: Icon(con.iconData),
      ),
    
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(kPadding),
        child: BottomNavigationBar(
          currentIndex: con.currnIndex,
          onTap: (value) => con.index(value),
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.task_outlined),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done_outline),
              label: 'Done',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined),
              label: 'Archive',
            ),
          ],
        ),
      ),
    );
  }
}
