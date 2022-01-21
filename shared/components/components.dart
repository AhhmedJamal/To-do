import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/provider.dart';

Widget textField({
  required TextEditingController controller,
  required TextInputType inputType,
  required String? Function(String? c) validate,
  required IconData perfix,
  required String label,
  VoidCallback? onTap,
}) =>
    SizedBox(
      width: 300,
      child: TextFormField(
        controller: controller,
        validator: validate,
        keyboardType: inputType,
        cursorWidth: 5,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(perfix),
        ),
        onTap: onTap,
      ),
    );
//=========================

Widget itemsData(
  Map model,
  BuildContext context,
) {
  var con = Provider.of<Providerr>(context);
  return Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (direction) {
      con.deleteData(id: model['id']);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${model['time']}'),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    '${model['title']}',
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${model['date']}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
              splashRadius: 25,
              onPressed: () {
                con.updateData(
                  status: 'done',
                  id: model['id'],
                );
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              )),
          IconButton(
              splashRadius: 25,
              onPressed: () {
                con.updateData(
                  status: 'archive',
                  id: model['id'],
                );
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.grey,
              )),
        ],
      ),
    ),
  );
}

Widget tasksBuilder({
  required List<Map> con,
}) =>
    ConditionalBuilder(
      condition: con.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => itemsData(
          con[index],
          context,
        ),
        separatorBuilder: (context, index) => Container(
          margin: const EdgeInsetsDirectional.only(start: 25),
          color: Colors.grey,
          height: 1,
          width: double.infinity,
        ),
        itemCount: con.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(
                width: 150,
                child: Text(
                  'No Tasks Yet, Please Add Some Tasks !!',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
