import 'package:flutter/material.dart';
import '../db_model.dart';
import './todo_card.dart';

class Todolist extends StatelessWidget {
  // create an object of database connect
  // to pass down to todocard, first our todolist have to receive the functions
  final Function insertFunction;
  final Function deleteFunction;
  final db = DatabaseConnect();
  Todolist(
      {required this.insertFunction, required this.deleteFunction, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Builder(
        builder: (context) {
          return SizedBox(
            child: Builder(
              builder: (context) {
                return SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: db.getTodo(),
                      initialData:  [],
                      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                        var data =
                            snapshot.data;
                        var datalength = data!.length;

                        return datalength == 0
                            ? const Center(
                          child: Text('no data found'),
                        )
                            : ListView.builder(
                          itemCount: datalength,
                          itemBuilder: (context, i) => Todocard(
                            id: data[i].id,
                            title: data[i].title,
                            creationDate: data[i].creationDate,
                            isChecked: data[i].isChecked,
                            insertFunction: insertFunction,
                            deleteFunction: deleteFunction,
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            ),
          );
        }
      ),
    );
  }
}