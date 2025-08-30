import 'package:flutter/material.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/role_selection_page.dart';
import 'pages/traveler/traveler_home.dart';
import 'pages/traveler/create_ride_page.dart';
import 'pages/traveler/active_ride_page.dart';
import 'pages/traveler/share_audit_page.dart';
import 'pages/companion/companion_home.dart';
import 'pages/companion/track_ride_page.dart';
import 'pages/companion/feedback_page.dart';
import 'pages/admin/admin_dashboard.dart';
import 'pages/admin/ride_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride Tracking Platform',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          secondary: Colors.amber,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/role-selection': (context) => const RoleSelectionPage(),
        '/traveler/home': (context) => const TravelerHome(),
        '/traveler/create-ride': (context) => const CreateRidePage(),
        '/traveler/active-ride': (context) => const ActiveRidePage(),
        '/traveler/share-audit': (context) => const ShareAuditPage(),
        '/companion/home': (context) => const CompanionHome(),
        '/companion/track': (context) => const TrackRidePage(),
        '/companion/feedback': (context) => const FeedbackPage(),
        '/admin/dashboard': (context) => const AdminDashboard(),
        '/admin/ride-detail': (context) => const RideDetailPage(),
      },
    );
  }
}
