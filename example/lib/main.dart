import 'package:flutter/material.dart';
import 'package:vertical_timeline_widget/vertical_timeline_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timeline Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const TimelineExamplesScreen(),
    );
  }
}

class TimelineExamplesScreen extends StatelessWidget {
  const TimelineExamplesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Timeline Examples'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Basic'),
              Tab(text: 'Custom Styled'),
              Tab(text: 'Themed'),
              Tab(text: 'Real World'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BasicTimelineExample(),
            CustomStyledTimelineExample(),
            ThemedTimelineExample(),
            RealWorldTimelineExample(),
          ],
        ),
      ),
    );
  }
}

/// Example 1: Basic Timeline
class BasicTimelineExample extends StatelessWidget {
  const BasicTimelineExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Timeline',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'A simple timeline with default styling. Each entry can have its own color.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          Timeline(
            data: [
              TimelineData(
                time: const Text('Jan 1'),
                title: const Text('Project Kickoff'),
                content: const Text(
                  'Initial meeting to discuss project scope, timeline, and team assignments.',
                ),
                color: Colors.green,
              ),
              TimelineData(
                time: const Text('Jan 15'),
                title: const Text('Design Phase'),
                content: const Text(
                  'Create wireframes and mockups for the main user interfaces.',
                ),
                color: Colors.blue,
              ),
              TimelineData(
                time: const Text('Feb 1'),
                title: const Text('Development'),
                content: const Text(
                  'Begin implementation of core features and functionality.',
                ),
                color: Colors.orange,
              ),
              TimelineData(
                time: const Text('Mar 1'),
                title: const Text('Testing'),
                content: const Text('Quality assurance testing and bug fixes.'),
                color: Colors.purple,
              ),
              TimelineData(
                time: const Text('Mar 15'),
                title: const Text('Launch'),
                content: const Text('Production deployment and go-live.'),
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Example 2: Custom Styled Timeline
class CustomStyledTimelineExample extends StatelessWidget {
  const CustomStyledTimelineExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Styled Timeline',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Customize spacing, dot size, connector thickness, and text styles directly on the widget.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),

          // Example with larger dots and more spacing
          Text(
            'Large Dots & Wide Spacing',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Timeline(
            dotSize: 20,
            spacing: 24,
            rowGap: 32,
            connectorThickness: 4,
            color: Colors.indigo,
            timeConstraints: const BoxConstraints(minWidth: 80, maxWidth: 80),
            data: [
              TimelineData(
                time: const Text('Step 1'),
                title: const Text('Research'),
                content: const Text('Gather requirements and analyze needs.'),
              ),
              TimelineData(
                time: const Text('Step 2'),
                title: const Text('Plan'),
                content: const Text('Create detailed project plan.'),
              ),
              TimelineData(
                time: const Text('Step 3'),
                title: const Text('Execute'),
                content: const Text('Implement the solution.'),
              ),
            ],
          ),

          const SizedBox(height: 48),

          // Example with square dots
          Text('Square Dots', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          Timeline(
            useCircularDots: false,
            dotSize: 14,
            color: Colors.deepOrange,
            data: [
              TimelineData(
                time: const Text('Q1'),
                title: const Text('Quarter 1 Goals'),
                content: const Text('Set up infrastructure and team.'),
              ),
              TimelineData(
                time: const Text('Q2'),
                title: const Text('Quarter 2 Goals'),
                content: const Text('Launch MVP and gather feedback.'),
              ),
              TimelineData(
                time: const Text('Q3'),
                title: const Text('Quarter 3 Goals'),
                content: const Text('Iterate based on user feedback.'),
              ),
            ],
          ),

          const SizedBox(height: 48),

          // Example with custom text styles
          Text(
            'Custom Text Styles',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Timeline(
            color: Colors.teal,
            timeTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.teal,
            ),
            titleTextStyle: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
            contentTextStyle: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.grey[700],
            ),
            data: [
              TimelineData(
                time: const Text('2020'),
                title: const Text('Company Founded'),
                content: const Text('Started with a small team of 3 people.'),
              ),
              TimelineData(
                time: const Text('2022'),
                title: const Text('Series A Funding'),
                content: const Text('Raised \$10M to expand operations.'),
              ),
              TimelineData(
                time: const Text('2024'),
                title: const Text('Global Expansion'),
                content: const Text('Opened offices in 5 countries.'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Example 3: Themed Timeline
class ThemedTimelineExample extends StatelessWidget {
  const ThemedTimelineExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Themed Timeline',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Use TimelineThemeData to apply consistent styling to all nested Timeline widgets.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),

          // Theme 1: Professional Blue
          Text(
            'Professional Theme',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          TimelineThemeData(
            theme: TimelineTheme(
              dotSize: 14,
              spacing: 20,
              rowGap: 20,
              color: const Color(0xFF1565C0),
              useCircularDots: true,
              timeTextStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Color(0xFF1565C0),
              ),
              titleTextStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Color(0xFF1A237E),
              ),
              contentTextStyle: const TextStyle(
                fontSize: 13,
                color: Color(0xFF546E7A),
              ),
            ),
            child: Timeline(
              data: [
                TimelineData(
                  time: const Text('9:00 AM'),
                  title: const Text('Team Standup'),
                  content: const Text(
                    'Daily sync meeting with the development team.',
                  ),
                ),
                TimelineData(
                  time: const Text('10:30 AM'),
                  title: const Text('Client Call'),
                  content: const Text(
                    'Review project progress with stakeholders.',
                  ),
                ),
                TimelineData(
                  time: const Text('2:00 PM'),
                  title: const Text('Code Review'),
                  content: const Text(
                    'Review and approve pending pull requests.',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 48),

          // Theme 2: Modern Dark
          Text(
            'Modern Dark Theme',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TimelineThemeData(
              theme: TimelineTheme(
                dotSize: 12,
                spacing: 16,
                rowGap: 24,
                color: const Color(0xFF00E676),
                useCircularDots: true,
                timeTextStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xFF00E676),
                  fontFamily: 'monospace',
                ),
                titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.white,
                ),
                contentTextStyle: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9E9E9E),
                ),
              ),
              child: Timeline(
                data: [
                  TimelineData(
                    time: const Text('v1.0.0'),
                    title: const Text('Initial Release'),
                    content: const Text('Core features implemented.'),
                  ),
                  TimelineData(
                    time: const Text('v1.1.0'),
                    title: const Text('Bug Fixes'),
                    content: const Text('Fixed critical issues.'),
                    color: const Color(0xFFFFEB3B),
                  ),
                  TimelineData(
                    time: const Text('v2.0.0'),
                    title: const Text('Major Update'),
                    content: const Text('New features and improvements.'),
                    color: const Color(0xFF2196F3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Example 4: Real World Use Cases
class RealWorldTimelineExample extends StatelessWidget {
  const RealWorldTimelineExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Real World Examples',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Common use cases for timeline widgets in real applications.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),

          // Order Tracking
          _buildSection(
            context,
            icon: Icons.local_shipping,
            title: 'Order Tracking',
            child: Timeline(
              color: Colors.green,
              dotSize: 14,
              data: [
                TimelineData(
                  time: const Text('Feb 1\n10:30 AM'),
                  title: const Text('Order Placed'),
                  content: const Text('Your order has been confirmed.'),
                  color: Colors.green,
                ),
                TimelineData(
                  time: const Text('Feb 2\n2:15 PM'),
                  title: const Text('Processing'),
                  content: const Text('Your order is being prepared.'),
                  color: Colors.green,
                ),
                TimelineData(
                  time: const Text('Feb 3\n9:00 AM'),
                  title: const Text('Shipped'),
                  content: const Text('Package handed to courier.'),
                  color: Colors.green,
                ),
                TimelineData(
                  time: const Text('Feb 5'),
                  title: const Text('Out for Delivery'),
                  content: const Text('Package is on its way to you.'),
                  color: Colors.orange,
                ),
                TimelineData(
                  time: const Text('Pending'),
                  title: const Text('Delivered'),
                  content: const Text('Waiting for delivery.'),
                  color: Colors.grey,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Activity Feed
          _buildSection(
            context,
            icon: Icons.history,
            title: 'Activity Feed',
            child: Timeline(
              timeConstraints: const BoxConstraints(minWidth: 60, maxWidth: 60),
              spacing: 12,
              rowGap: 12,
              dotSize: 10,
              data: [
                TimelineData(
                  time: const Text('2m ago'),
                  title: const Text('John commented on your post'),
                  color: Colors.blue,
                ),
                TimelineData(
                  time: const Text('15m ago'),
                  title: const Text('Sarah liked your photo'),
                  color: Colors.pink,
                ),
                TimelineData(
                  time: const Text('1h ago'),
                  title: const Text('New follower: Mike'),
                  color: Colors.purple,
                ),
                TimelineData(
                  time: const Text('3h ago'),
                  title: const Text('Your post was shared 5 times'),
                  color: Colors.green,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Work Experience
          _buildSection(
            context,
            icon: Icons.work,
            title: 'Work Experience',
            child: Timeline(
              color: Colors.blueGrey,
              dotSize: 16,
              rowGap: 24,
              timeConstraints: const BoxConstraints(
                minWidth: 100,
                maxWidth: 100,
              ),
              timeTextStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              data: [
                TimelineData(
                  time: const Text('2022 - Present'),
                  title: const Text('Senior Developer'),
                  content: const Text(
                    'Tech Corp Inc.\nLeading the mobile development team.',
                  ),
                  color: Colors.blue,
                ),
                TimelineData(
                  time: const Text('2019 - 2022'),
                  title: const Text('Software Developer'),
                  content: const Text(
                    'StartUp Labs\nBuilt customer-facing applications.',
                  ),
                  color: Colors.teal,
                ),
                TimelineData(
                  time: const Text('2017 - 2019'),
                  title: const Text('Junior Developer'),
                  content: const Text(
                    'Digital Agency\nWeb and mobile app development.',
                  ),
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
