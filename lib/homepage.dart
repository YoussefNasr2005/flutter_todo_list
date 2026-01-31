import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeLearning();
}

class Counters {
  int myNameCounter = 0;
  int importantsCounter = 0;
  int tasksCounter = 0;
  int assignedCounter = 0;
}

class _HomeLearning extends State<HomePage> {
  String userName = "Youssef Nasr";
  String userGmail = "youssefnasr2005date@gmail.com";
  String appBarTitle = "Let’s organize your tasks!";
  String selectedListTitle = "Home";

  Counters counters = Counters();

  final List<Map<String, dynamic>> items = [
    {
      "icon": Icons.wb_sunny_outlined,
      "color": Colors.amber,
      "title": "My Day",
      "count": 0
    },
    {
      "icon": Icons.star_border,
      "color": Colors.redAccent,
      "title": "Important",
      "count": 0,
    },
    {
      "icon": Icons.check_box_outlined,
      "color": Colors.lightGreen,
      "title": "Tasks",
      "count": 0,
    },
    {
      "icon": Icons.note_alt_outlined,
      "color": Colors.blue,
      "title": "Planned",
      "count": 0,
    },
    {
      "icon": Icons.person_2_outlined,
      "color": Colors.blue,
      "title": "Assigned to me",
      "count": 0,
    },
  ];

  Map<String, List<Map<String, String>>> tasks = {
    "My Day": [],
    "Important": [],
    "Tasks": [],
    "Planned": [],
    "Assigned to me": [],
  };

  List<Map<String, dynamic>> filteredItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = items;
    searchController.addListener(filterItems);
  }

  void filterItems() {
    final query = searchController.text.toString().toLowerCase();
    setState(() {
      filteredItems = items.where((currenutIndex) {
        final title = currenutIndex['title'].toString().toLowerCase();
        return title.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  String formatDate(String? dateString) {
    if (dateString == null) return '';
    final date = DateTime.tryParse(dateString);
    if (date == null) return '';

    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: selectedListTitle == "Home"
          ? null
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  tasks[selectedListTitle]?.add({
                    'title': 'New Task',
                    'subTitle': 'Details',
                    'date': DateTime.now().toString(),
                  });

                  final index = items.indexWhere(
                    (item) => item['title'] == selectedListTitle,
                  );

                  if (index != -1) {
                    items[index]['count'] = tasks[selectedListTitle]!.length;
                  }

                  filteredItems = List.from(items);
                });
              },
              backgroundColor: Colors.black,
              child: Text(
                '+',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white, fontSize: 35),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 10),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/MyPhoto.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      userName,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.amberAccent),
                    ),
                    subtitle: Text(
                      userGmail,
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextField(
                  controller: searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    label: const Text('Search'),
                    labelStyle: const TextStyle(color: Colors.white60),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide()),
                    fillColor: Colors.black54,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          setState(() {
                            selectedListTitle = filteredItems[index]['title'];
                            appBarTitle = filteredItems[index]['title'];
                          });
                          Navigator.pop(context);
                        },
                        leading: Icon(
                          filteredItems[index]['icon'],
                          color: filteredItems[index]['color'],
                        ),
                        title: Text(
                          filteredItems[index]['title'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        trailing: Text(
                          '${filteredItems[index]['count']}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          appBarTitle,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 82, 11, 11),
      body: Center(
        child: selectedListTitle == "Home"
            ? const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Select a note category to get started.',
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                ),
                Icon(
                  Icons.menu,
                  size: 25,
                  color: Colors.white70,
                )
              ])
            : ListView.builder(
                itemCount: tasks[selectedListTitle]?.length ?? 0,
                itemBuilder: (context, index) {
                  final task = tasks[selectedListTitle]![index];
                  return Card(
                    child: ListTile(
                      leading: Text(
                        formatDate(task['date']),
                        style: const TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            final titleController =
                                TextEditingController(text: task['title']);
                            final subController =
                                TextEditingController(text: task['subTitle']);

                            return AlertDialog(
                              title: const Text('Edit Task'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(controller: titleController),
                                  TextField(controller: subController),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      task['title'] = titleController.text;
                                      task['subTitle'] = subController.text;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      title: Text(
                        task['title'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        task['subTitle'] ?? '',
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 186, 37, 26),
                        ),
                        onPressed: () {
                          setState(() {
                            tasks[selectedListTitle]!.removeAt(index);

                            final itemIndex = items.indexWhere(
                              (item) => item['title'] == selectedListTitle,
                            );

                            if (itemIndex != -1) {
                              items[itemIndex]['count'] =
                                  tasks[selectedListTitle]!.length;
                            }
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
