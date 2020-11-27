import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addTask.dart';
import 'model.dart';

class TodoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: _buildBody(context),
      floatingActionButton: _addButton(context),
    );
  }

  //Widget som bygger listan som visas i bodyn
  Widget _buildBody(BuildContext context) {
    return Consumer<MyState>(
      builder: (context, state, child) => ListView.builder(
          itemCount: state.getTasks.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide()),
              ),
              child: ListTile(
                leading: Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.black),
                    child: Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: state.getDone(index),
                        onChanged: (bool done) {
                          state.setDone(index, done);
                        })),
                title: state.getTask(index),
                trailing: IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    state.delete(index);
                  },
                ),
              ),
            );
          }),
    );
  }

  Widget customAppbar() {
    return (AppBar(
      title: Text("TIG169 TODO", style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.grey,
      centerTitle: true,
      actions: [_popupButton()],
    ));
  }

  Widget _addButton(context) {
    return (FloatingActionButton(
        backgroundColor: Colors.grey,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          var newTask = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTask(Todo())));
          if (newTask != null) {
            Provider.of<MyState>(context, listen: false).addTask(newTask);
          }
        }));
  }

  Widget _popupButton() {
    return Consumer<MyState>(
        builder: (context, state, child) => PopupMenuButton(
              child: Icon(Icons.more_vert, color: Colors.black),
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
