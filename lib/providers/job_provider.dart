import 'package:flutter/material.dart';
import '../models/job_model.dart';
import '../services/job_service.dart';

enum JobState { loading, loaded, empty, error }

class JobProvider extends ChangeNotifier {
  final JobService _jobService = JobService();

  List<Job> _allJobs = [];
  List<Job> _filteredJobs = [];
  JobState _state = JobState.loading;
  String _errorMessage = '';
  String _searchQuery = '';
  String _selectedJobType = 'All';

  final Set<String> _favoriteJobIds = {};

  List<Job> get jobs => _filteredJobs;
  JobState get state => _state;
  String get errorMessage => _errorMessage;
  String get selectedJobType => _selectedJobType;
  Set<String> get favoriteJobIds => _favoriteJobIds;

  List<Job> get favoriteJobs =>
      _allJobs.where((job) => _favoriteJobIds.contains(job.id)).toList();

  bool isFavorite(String jobId) => _favoriteJobIds.contains(jobId);

  Future<void> fetchJobs() async {
    _state = JobState.loading;
    notifyListeners();

    try {
      _allJobs = await _jobService.fetchJobs();
      _applyFilters();
    } catch (e) {
      _state = JobState.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void search(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterByType(String jobType) {
    _selectedJobType = jobType;
    _applyFilters();
  }

  void _applyFilters() {
    List<Job> result = _allJobs;

    if (_selectedJobType != 'All') {
      result = result.where((job) => job.jobType == _selectedJobType).toList();
    }

    if (_searchQuery.isNotEmpty) {
      result = result.where((job) {
        final query = _searchQuery.toLowerCase();
        return job.title.toLowerCase().contains(query) ||
            job.companyName.toLowerCase().contains(query);
      }).toList();
    }

    _filteredJobs = result;
    _state = _filteredJobs.isEmpty ? JobState.empty : JobState.loaded;
    notifyListeners();
  }

  void toggleFavorite(String jobId) {
    if (_favoriteJobIds.contains(jobId)) {
      _favoriteJobIds.remove(jobId);
    } else {
      _favoriteJobIds.add(jobId);
    }
    notifyListeners();
  }
}
