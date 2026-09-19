import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/job_provider.dart';
import '../widgets/job_card.dart';
import 'job_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JobProvider>();
    final favJobs = provider.favoriteJobs;

    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Jobs')),
      body: favJobs.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No favorites yet.\nTap the heart icon on any job to save it here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
            )
          : ListView.builder(
              itemCount: favJobs.length,
              itemBuilder: (context, index) {
                final job = favJobs[index];
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
