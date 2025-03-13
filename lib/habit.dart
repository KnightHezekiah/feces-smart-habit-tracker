import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit {
  @HiveField(0)
  String name;

  @HiveField(1)
  int streak;

  @HiveField(2)
  int points;

  @HiveField(3)
  DateTime lastCompleted;

  Habit({
    required this.name,
    this.streak = 0,
    this.points = 0,
    DateTime? lastCompleted,
  }) : lastCompleted = lastCompleted ?? DateTime.now();
}
