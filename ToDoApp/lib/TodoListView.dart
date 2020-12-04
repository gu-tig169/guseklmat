//klass för listan som visas på förstasidan.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addTask.dart';
import 'model.dart';

class TodoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context),
      body: _buildBody(context),
      floatingActionButton: _addButton(context),
      backgroundColor:
          Provider.of<MyState>(context, listen: false).getMainColor(),
    );
  }

  //Widget som bygger listan som visas i bodyn.
  Widget _buildBody(BuildContext context) {
    return Consumer<MyState>(
      builder: (context, state, child) => ListView.builder(
          itemCount: state.getTasks.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: (index % 2 == 0
                      ? Colors.grey[50]
                      : state.getMainColor())),
              child: ListTile(
                leading: Theme(
                    data:
                        ThemeData(unselectedWidgetColor: state.getThirdColor()),
                    child: Checkbox(
                        activeColor: state.getSecondColor(),
                        checkColor: Colors.white,
                        value: state.getDone(index),
                        onChanged: (bool done) {
                          state.setDone(index, done);
                        })),
                title: state.getTask(index),
                trailing: IconButton(
                  icon:
                      Icon(Icons.close, color: state.getThirdColor(), size: 30),
                  onPressed: () {
                    state.delete(index);
                  },
                ),
              ),
            );
          }),
    );
  }

  //Appbaren för "TodoListView".
  Widget customAppbar(context) {
    return (AppBar(
      title: Text("TIG169 TODO",
          style: TextStyle(
            color: Provider.of<MyState>(context, listen: false).getThirdColor(),
          )),
      backgroundColor:
          Provider.of<MyState>(context, listen: false).getSecondColor(),
      centerTitle: true,
      actions: [_popupButton()],
    ));
  }

  //Knappen för att gå till "add-Task-sidan".
  Widget _addButton(context) {
    return (FloatingActionButton(
        backgroundColor:
            Provider.of<MyState>(context, listen: false).getSecondColor(),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          var newTask = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTask(Todo())));
          if (newTask != null) {
            Provider.of<MyState>(context, listen: false).addTask(newTask);
          }
        }));
  }

  //Menyn i appbaren.
  Widget _popupButton() {
    return Consumer<MyState>(
        builder: (context, state, child) => PopupMenuButton(
              child: Icon(Icons.more_vert, color: state.getThirdColor()),
              onSelected: (newValue) {
                state.setFilterValue(newValue);
                state.useFilter();
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: "All",
                  child: Text("All"),
                ),
                PopupMenuItem(
                  value: "Done",
                  child: Text("Done"),
                ),
                PopupMenuItem(
                  value: "Undone",
                  child: Text("Undone"),
                ),
              ],
            ));
  }
}
