import 'package:hive/hive.dart';

part 'resume_item.g.dart';

@HiveType(typeId: 0)
class ResumeItem extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  ResumeItem({required this.title, required this.description});
}
