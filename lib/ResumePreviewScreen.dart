import 'package:flutter/material.dart';
import 'models/resume_data.dart';

class ResumePreviewScreen extends StatelessWidget {
  final ResumeData resumeData;


  const ResumePreviewScreen({super.key, required this.resumeData});

  Widget _sectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(width: 5, height: 25, color: Colors.teal),
          const SizedBox(width: 8),
          Text(title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary)),
        ],
      ),
    );
  }

  Widget _buildKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Text(key, style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(flex: 7, child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
            child: Stack(
              children: [
                Center(
                  child: const Text(
                    "Resume Preview",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // go back to main form
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (you can add name & title here later)
                Center(
                  child: Text(
                    resumeData.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    resumeData.title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Summary
                _sectionTitle(context, "Summary"),
                Text(resumeData.summary, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 12),

                // Education
                if (resumeData.education.isNotEmpty) ...[
                  _sectionTitle(context, "Education"),
                  Column(
                    children: resumeData.education.map((edu) {
                      return Card(
                        color: Colors.teal.shade50,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(edu["institution"] ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(edu["degree"] ?? ""),
                              Text(edu["year"] ?? "",
                                  style: TextStyle(color: Colors.grey.shade700)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],

                // Work Experience
                if (resumeData.work.isNotEmpty) ...[
                  _sectionTitle(context, "Work Experience"),
                  Column(
                    children: resumeData.work.map((w) {
                      return Card(
                        color: Colors.teal.shade50,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(w["role"] ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(w["company"] ?? ""),
                              Text(w["duration"] ?? "",
                                  style: TextStyle(color: Colors.grey.shade700)),
                              if (w["responsibilities"] != null &&
                                  w["responsibilities"]!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(w["responsibilities"] ?? ""),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],

                // Skills
                if (resumeData.skills.isNotEmpty) ...[
                  _sectionTitle(context, "Skills"),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: resumeData.skills
                        .map((s) => Chip(
                      backgroundColor: Colors.teal.shade100,
                      label: Text(s),
                    ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                ],

                // Projects
                if (resumeData.projects.isNotEmpty) ...[
                  _sectionTitle(context, "Projects"),
                  Column(
                    children: resumeData.projects.map((p) {
                      return Card(
                        color: Colors.teal.shade50,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p["title"] ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(p["description"] ?? ""),
                              if (p["link"] != null && p["link"]!.isNotEmpty)
                                Text(p["link"] ?? "",
                                    style: TextStyle(
                                        color: Colors.blue.shade700)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],

                // Achievements
                if (resumeData.achievements.isNotEmpty) ...[
                  _sectionTitle(context, "Achievements"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: resumeData.achievements
                        .map((a) => Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          const Icon(Icons.check, size: 16),
                          const SizedBox(width: 6),
                          Expanded(child: Text(a)),
                        ],
                      ),
                    ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                ],

                // Certifications
                if (resumeData.certifications.isNotEmpty) ...[
                  _sectionTitle(context, "Certifications"),
                  Column(
                    children: resumeData.certifications.map((c) {
                      return Card(
                        color: Colors.teal.shade50,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c["name"] ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(c["issuer"] ?? ""),
                              if (c["year"] != null) Text(c["year"] ?? ""),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
