class ResumeData {
  final String name;       // new
  final String title;      // new
  final String summary;
  final List<Map<String, String>> education;
  final List<Map<String, String>> work;
  final List<Map<String, String>> certifications;
  final List<Map<String, String>> projects;
  final List<String> skills;
  final List<String> achievements;

  ResumeData({
    required this.name,
    required this.title,
    required this.summary,
    required this.education,
    required this.work,
    required this.certifications,
    required this.projects,
    required this.skills,
    required this.achievements,
  });
}
