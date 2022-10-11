import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_app/models/activity.dart';

import '../widgets/custom_header.dart';
import 'activity_detaile_screen.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  static const routeName = '/activities';

  @override
  Widget build(BuildContext context) {
    List<Activity> activities = Activity.activities;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          const CustomHeader(
            title: 'Activities',
          ),
          _ActivitiesMasonryGrid(
            activities: activities,
            width: width,
          )
        ],
      ),
    );
  }
}

class _ActivitiesMasonryGrid extends StatelessWidget {
  const _ActivitiesMasonryGrid({
    Key? key,
    required this.activities,
    required this.width,
    this.mansoryCardHeights = const [200, 250, 300],
  }) : super(key: key);

  final List<double> mansoryCardHeights;

  final List<Activity> activities;
  final double width;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemCount: 9,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemBuilder: (context, index) {
        Activity activity = activities[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActivityDetailScreen(
                  activity: activity,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Hero(
                tag: '${activity.id}_${activity.title}',
                child: Container(
                  height: mansoryCardHeights[index % 3],
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(activity.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                activity.title,
                maxLines: 3,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
              )
            ],
          ),
        );
      },
    );
  }
}
