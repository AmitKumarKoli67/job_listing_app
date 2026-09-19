import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/job_provider.dart';
import '../widgets/job_card.dart';
import 'job_details_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JobProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Listings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by title or company...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => provider.search(value),
            ),
          ),

          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: ['All', 'Internship', 'Full-time'].map((type) {
                final isSelected = provider.selectedJobType == type;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(type),
                    selected: isSelected,
                    onSelected: (_) => provider.filterByType(type),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),

          Expanded(child: _buildBody(provider)),
        ],
      ),
    );
  }

  Widget _buildBody(JobProvider provider) {
    switch (provider.state) {
      case JobState.loading:
        return const Center(child: CircularProgressIndicator());
      case JobState.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              Text(
                'Something went wrong\n${provider.errorMessage}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: provider.fetchJobs,
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      case JobState.empty:
        return RefreshIndicator(
          onRefresh: provider.fetchJobs,
          child: ListView(
            children: const [
              SizedBox(height: 100),
              Center(child: Text('No jobs found')),
            ],
          ),
        );
      case JobState.loaded:
        return RefreshIndicator(
          onRefresh: provider.fetchJobs,
          child: ListView.builder(
            itemCount: provider.jobs.length,
            itemBuilder: (context, index) {
              final job = provider.jobs[index];
              return JobCard(
                job: job,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => JobDetailsScreen(job: job),
                    ),
                  );
                },
              );
            },
          ),
        );
    }
  }
}
