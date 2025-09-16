// main.dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Builder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ResumeFormScreen(),
    );
  }
}

class ResumeFormScreen extends StatefulWidget {
  const ResumeFormScreen({super.key});

  @override
  State<ResumeFormScreen> createState() => _ResumeFormScreenState();
}

class _ResumeFormScreenState extends State<ResumeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController summaryController = TextEditingController();

  // dynamic lists for education/work/projects/certifications
  final List<Map<String, TextEditingController>> education = [];
  final List<Map<String, TextEditingController>> work = [];
  final List<Map<String, TextEditingController>> certifications = [];
  final List<Map<String, TextEditingController>> projects = [];

  // skills & achievements
  final TextEditingController skillController = TextEditingController();
  final List<String> skills = [];
  final TextEditingController achievementController = TextEditingController();
  final List<String> achievements = [];

  @override
  void initState() {
    super.initState();
    addEducation(); // start with one
    addWork();
    addCertification();
    addProject();
  }

  // helpers to create entry maps
  Map<String, TextEditingController> _newEducationEntry() {
    return {
      'institution': TextEditingController(),
      'degree': TextEditingController(),
      'year': TextEditingController(),
    };
  }

  Map<String, TextEditingController> _newWorkEntry() {
    return {
      'company': TextEditingController(),
      'role': TextEditingController(),
      'duration': TextEditingController(),
      'responsibilities': TextEditingController(),
    };
  }

  Map<String, TextEditingController> _newCertificationEntry() {
    return {
      'name': TextEditingController(),
      'issuer': TextEditingController(),
      'year': TextEditingController(),
    };
  }

  Map<String, TextEditingController> _newProjectEntry() {
    return {
      'title': TextEditingController(),
      'description': TextEditingController(),
      'link': TextEditingController(),
    };
  }

  void addEducation() {
    setState(() {
      education.add(_newEducationEntry());
    });
  }

  void removeEducation(int index) {
    final e = education.removeAt(index);
    e.values.forEach((c) => c.dispose());
    setState(() {});
  }

  void addWork() {
    setState(() {
      work.add(_newWorkEntry());
    });
  }

  void removeWork(int index) {
    final w = work.removeAt(index);
    w.values.forEach((c) => c.dispose());
    setState(() {});
  }

  void addCertification() {
    setState(() {
      certifications.add(_newCertificationEntry());
    });
  }

  void removeCertification(int index) {
    final c = certifications.removeAt(index);
    c.values.forEach((ctl) => ctl.dispose());
    setState(() {});
  }

  void addProject() {
    setState(() {
      projects.add(_newProjectEntry());
    });
  }

  void removeProject(int index) {
    final p = projects.removeAt(index);
    p.values.forEach((ctl) => ctl.dispose());
    setState(() {});
  }

  void addSkill() {
    final text = skillController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      skills.add(text);
      skillController.clear();
    });
  }

  void removeSkill(int index) {
    setState(() {
      skills.removeAt(index);
    });
  }

  void addAchievement() {
    final t = achievementController.text.trim();
    if (t.isEmpty) return;
    setState(() {
      achievements.add(t);
      achievementController.clear();
    });
  }

  void removeAchievement(int index) {
    setState(() {
      achievements.removeAt(index);
    });
  }

  InputDecoration _fieldDecoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon) : null,
      filled: true,
      fillColor: Theme.of(context).colorScheme.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    );
  }

  Widget _sectionCard({required Widget child, required String title, required IconData icon}) {
    return Card(
      color: Colors.teal.shade100,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    summaryController.dispose();
    skillController.dispose();
    achievementController.dispose();
    for (final e in education) {
      e.values.forEach((c) => c.dispose());
    }
    for (final w in work) {
      w.values.forEach((c) => c.dispose());
    }
    for (final c in certifications) {
      c.values.forEach((ctl) => ctl.dispose());
    }
    for (final p in projects) {
      p.values.forEach((ctl) => ctl.dispose());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade400, Colors.teal.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Resume Builder",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // header
             Container(
               width: double.infinity,
               height: 50,
               decoration: BoxDecoration(
                 color: Colors.teal.shade100,
                 borderRadius: BorderRadius.circular(10),
               ),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Center(child: Text("Start Building Your Professional resume",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),)),
               ),
               
             ),

              const SizedBox(height: 18),

              // Summary
              _sectionCard(
                title: 'Summary',
                icon: Icons.rss_feed,
                child: TextFormField(
                  controller: summaryController,
                  decoration: _fieldDecoration('Write a short professional summary', icon: Icons.edit),
                  maxLines: 4,
                ),
              ),

              // Education - dynamic
              _sectionCard(
                title: 'Education',
                icon: Icons.school,
                child: Column(
                  children: [
                    ...List.generate(education.length, (i) {
                      final e = education[i];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Education ${i+1}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                      const Spacer(),
                                      if (education.length > 1)
                                        IconButton(
                                          onPressed: () => removeEducation(i),
                                          icon: const Icon(Icons.delete_outline),
                                        )
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(controller: e['institution'], decoration: _fieldDecoration('College / University')),
                                  const SizedBox(height: 10),
                                  TextField(controller: e['degree'], decoration: _fieldDecoration('Degree / Course')),
                                  const SizedBox(height: 10),
                                  TextField(controller: e['year'], decoration: _fieldDecoration('Year of Passing')),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: addEducation,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Education'),
                      ),
                    ),
                  ],
                ),
              ),

              // Work Experience - dynamic
              _sectionCard(
                title: 'Work Experience',
                icon: Icons.work_outline,
                child: Column(
                  children: [
                    ...List.generate(work.length, (i) {
                      final w = work[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Experience ${i+1}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                  const Spacer(),
                                  if (work.length > 1)
                                    IconButton(onPressed: () => removeWork(i), icon: const Icon(Icons.delete_outline)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextField(controller: w['company'], decoration: _fieldDecoration('Company Name')),
                              const SizedBox(height: 10),
                              TextField(controller: w['role'], decoration: _fieldDecoration('Job Title')),
                              const SizedBox(height: 10),
                              TextField(controller: w['duration'], decoration: _fieldDecoration('Duration (e.g. Jan 2021 - Dec 2022)')),
                              const SizedBox(height: 10),
                              TextField(controller: w['responsibilities'], decoration: _fieldDecoration('Responsibilities'), maxLines: 3),
                            ],
                          ),
                        ),
                      );
                    }),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(onPressed: addWork, icon: const Icon(Icons.add), label: const Text('Add Experience')),
                    ),
                  ],
                ),
              ),

              // Skills
              _sectionCard(
                title: 'Skills',
                icon: Icons.star,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(controller: skillController, decoration: _fieldDecoration('Add a skill (e.g. Flutter)')),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(onPressed: addSkill, child: const Text('Add')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (skills.isNotEmpty)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List.generate(skills.length, (i) {
                            return Chip(
                              label: Text(skills[i]),
                              onDeleted: () => removeSkill(i),
                            );
                          }),
                        ),
                      ),
                  ],
                ),
              ),

              // Certifications
              _sectionCard(
                title: 'Certifications',
                icon: Icons.card_membership,
                child: Column(
                  children: [
                    ...List.generate(certifications.length, (i) {
                      final c = certifications[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Certificate ${i+1}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                  const Spacer(),
                                  if (certifications.length > 1)
                                    IconButton(onPressed: () => removeCertification(i), icon: const Icon(Icons.delete_outline)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextField(controller: c['name'], decoration: _fieldDecoration('Certification Name')),
                              const SizedBox(height: 10),
                              TextField(controller: c['issuer'], decoration: _fieldDecoration('Issuer')),
                              const SizedBox(height: 10),
                              TextField(controller: c['year'], decoration: _fieldDecoration('Year')),
                            ],
                          ),
                        ),
                      );
                    }),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(onPressed: addCertification, icon: const Icon(Icons.add), label: const Text('Add Certification')),
                    ),
                  ],
                ),
              ),

              // Projects
              _sectionCard(
                title: 'Projects',
                icon: Icons.build,
                child: Column(
                  children: [
                    ...List.generate(projects.length, (i) {
                      final p = projects[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Project ${i+1}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                  const Spacer(),
                                  if (projects.length > 1)
                                    IconButton(onPressed: () => removeProject(i), icon: const Icon(Icons.delete_outline)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextField(controller: p['title'], decoration: _fieldDecoration('Project Title')),
                              const SizedBox(height: 10),
                              TextField(controller: p['description'], decoration: _fieldDecoration('Description'), maxLines: 3),
                              const SizedBox(height: 10),
                              TextField(controller: p['link'], decoration: _fieldDecoration('Link (optional)')),
                            ],
                          ),
                        ),
                      );
                    }),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(onPressed: addProject, icon: const Icon(Icons.add), label: const Text('Add Project')),
                    ),
                  ],
                ),
              ),

              // Achievements
              _sectionCard(
                title: 'Achievements',
                icon: Icons.emoji_events,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: TextField(controller: achievementController, decoration: _fieldDecoration('Add an achievement'))),
                        const SizedBox(width: 8),
                        ElevatedButton(onPressed: addAchievement, child: const Text('Add')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (achievements.isNotEmpty)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(achievements.length, (i) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(achievements[i]),
                              trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => removeAchievement(i)),
                            );
                          }),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: validate & go to preview/export
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Open Preview — not implemented yet')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preview not implemented — form validated')));
                    }
                  },
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Preview Resume', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
