import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/job_model.dart';

class JobService {
  Future<List<Job>> fetchJobs() async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      final String jsonString = await rootBundle.loadString(
        'lib/data/jobs_mock.json',
        // 'lib/data/jobs_Mock.json'  // to check error state
      );
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((jobJson) => Job.fromJson(jobJson)).toList();
    } catch (e) {
      throw Exception('Failed to load jobs: $e');
    }
  }
}
