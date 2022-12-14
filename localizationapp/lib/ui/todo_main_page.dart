import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:localizationapp/data/dummy_data.dart';
import 'package:localizationapp/models/task.dart';
import 'package:localizationapp/ui/screen/all_tasks_screen.dart';
import 'package:localizationapp/ui/screen/complete_tasks_screen.dart';
import 'package:localizationapp/ui/screen/incomplete_tasks_screen.dart';

class TodoMainPage extends StatefulWidget {
  @override
  State<TodoMainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TodoMainPage>
    with SingleTickerProviderStateMixin {
  upStateAllScreens(Task task) {
    task.isComplete = !task.isComplete;
    setState(() {});
  }

  deleteTask(Task task) {
    allTasks.remove(task);
  }

  TabController tabController;
  initTabController() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      String message = tabController.index == 0
          ? 'you are in the all tasks tab'
          : tabController.index == 1
              ? 'you are in the complete task'
              : 'you are in the incomplete task';
      log(message);
    });
  }

  @override
  void initState() {
    // Todo:implement initState
    super.initState();
    initTabController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.done),
              onPressed: () {
                tabController.animateTo(1);
              },
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text('O'),
                      ),
                      accountName: Text('Omar'),
                      accountEmail: Text('omar@gmail.com')),
                  ListTile(
                    onTap: () {
                      tabController.animateTo(0);
                    },
                    title: Text('All Tasks'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      tabController.animateTo(1);
                    },
                    title: Text('Complete Tasks'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      tabController.animateTo(2);
                    },
                    title: Text('InComplete Tasks'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text('TODO APP'),
              bottom: TabBar(
                controller: tabController,
                tabs: [
                  Tab(
                    icon: Icon(Icons.list),
                  ),
                  Tab(
                    icon: Icon(Icons.done),
                  ),
                  Tab(
                    icon: Icon(Icons.cancel_outlined),
                  ),
                ],
              ),
            ),
            // bottomNavigationBar: BottomNavigationBar(
            //   currentIndex: index,
            //   onTap: (newindex) {
            //     setState(() {
            //       this.index = newindex;
            //     });
            //   },
            //   items: [
            //     BottomNavigationBarItem(label: 'All', icon: Icon(Icons.list)),
            //     BottomNavigationBarItem(label: 'Complete', icon: Icon(Icons.done)),
            //     BottomNavigationBarItem(
            //         label: 'InComplete', icon: Icon(Icons.cancel)),
            //   ],
            // ),
            body: TabBarView(controller: tabController, children: [
              allTaskScreen(upStateAllScreens, deleteTask),
              CompleteTaskScreen(upStateAllScreens, deleteTask),
              IncompleteTaskScreen(upStateAllScreens, deleteTask),
            ]))
        : Scaffold(
            appBar: AppBar(
              title: Text('TODO APP'),
            ),
            body: Row(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      UserAccountsDrawerHeader(
                          currentAccountPicture: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text('O'),
                          ),
                          accountName: Text('Omar'),
                          accountEmail: Text('omar@gmail.com')),
                      ListTile(
                        onTap: () {
                          tabController.animateTo(0);
                        },
                        title: Text('All Tasks'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {
                          tabController.animateTo(1);
                        },
                        title: Text('Complete Tasks'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {
                          tabController.animateTo(2);
                        },
                        title: Text('InComplete Tasks'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(controller: tabController, children: [
                  allTaskScreen(upStateAllScreens, deleteTask),
                  CompleteTaskScreen(upStateAllScreens, deleteTask),
                  IncompleteTaskScreen(upStateAllScreens, deleteTask),
                ])),
              ],
            ),
          );
  }
}
