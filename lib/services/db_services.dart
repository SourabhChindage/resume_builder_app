import 'package:hive/hive.dart';
import '../models/resume_item.dart';




class DBService {
  static const String boxName = "resumeItems";

  static Future<void> init() async {
    await Hive.openBox<ResumeItem>(boxName);
  }

  static Future<void> addItem(ResumeItem item) async {
    var box = Hive.box<ResumeItem>(boxName);
    await box.add(item);
  }

  static List<ResumeItem> getItems() {
    var box = Hive.box<ResumeItem>(boxName);
    return box.values.toList();
  }

  static Future<void> deleteItem(int index) async {
    var box = Hive.box<ResumeItem>(boxName);
    await box.deleteAt(index);
  }

  static Future<void> updateItem(int index, ResumeItem item) async {
    var box = Hive.box<ResumeItem>(boxName);
    await box.putAt(index, item);
  }
}
