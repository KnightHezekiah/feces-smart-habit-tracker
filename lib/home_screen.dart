import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'habit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _habitBox = Hive.box<Habit>('habits');
  final TextEditingController _habitController = TextEditingController();

  void _addHabit() {
    if (_habitController.text.isNotEmpty) {
      _habitBox.add(Habit(name: _habitController.text));
      _habitController.clear();
      setState(() {});
    }
  }

  void _deleteHabit(int index) {
    _habitBox.deleteAt(index);
    setState(() {});
  }

  void _markComplete(int index) {
    Habit? habit = _habitBox.getAt(index);
    if (habit != null) {
      habit.streak++;
      habit.points += 10;
      _habitBox.putAt(index, habit);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Smart Habit Tracker")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _habitController,
                    decoration: const InputDecoration(
                      labelText: "New Habit",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addHabit,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _habitBox.listenable(),
              builder: (context, Box<Habit> habits, _) {
                return habits.isEmpty
                    ? const Center(child: Text("No habits added yet!"))
                    : ListView.builder(
                      itemCount: habits.length,
                      itemBuilder: (context, index) {
                        Habit habit = habits.getAt(index)!;
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: ListTile(
                            title: Text(habit.name),
                            subtitle: Text(
                              "Streak: ${habit.streak} | Points: ${habit.points}",
                            ),
                            leading: Checkbox(
                              value: false,
                              onChanged: (_) => _markComplete(index),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteHabit(index),
                            ),
                          ),
                        );
                      },
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
