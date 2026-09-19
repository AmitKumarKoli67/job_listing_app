class Job {
  final String id;
  final String title;
  final String companyName;
  final String companyLogo;
  final String location;
  final String jobType;
  final String stipendOrSalary;
  final String description;
  final List<String> requiredSkills;
  final String experienceRequired;

  Job({
    required this.id,
    required this.title,
    required this.companyName,
    required this.companyLogo,
    required this.location,
    required this.jobType,
    required this.stipendOrSalary,
    required this.description,
    required this.requiredSkills,
    required this.experienceRequired,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      companyName: json['companyName'],
      companyLogo: json['companyLogo'],
      location: json['location'],
      jobType: json['jobType'],
      stipendOrSalary: json['stipendOrSalary'],
      description: json['description'],
      requiredSkills: List<String>.from(json['requiredSkills']),
      experienceRequired: json['experienceRequired'],
    );
  }
}
