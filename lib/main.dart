import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ride_tracking_platform/data/services/ride_service.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'config/theme.dart';
import 'constants/routes.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/signup_page.dart';
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
import 'data/repositories/firebase_auth_repository.dart';
import 'data/services/auth_service.dart';
import 'domain/usecases/auth_usecases.dart';
import 'data/repositories/firebase_ride_repository.dart';
import 'domain/repositories/ride_repository.dart';
import 'domain/usecases/ride_usecases.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Correct initialization order
  final firebaseAuth = FirebaseAuth.instance;
  final authService = AuthService(
    firebaseAuth: firebaseAuth,
    authRepository: null,
  );
  final authRepository = FirebaseAuthRepository(authService);

  // Update auth service with repository
  final finalAuthService = AuthService(
    firebaseAuth: firebaseAuth,
    authRepository: authRepository,
  );

  // Initialize use cases with repository
  final signUpUseCase = SignUpUseCase(authRepository);
  final signInUseCase = SignInUseCase(authRepository);
  final signOutUseCase = SignOutUseCase(authRepository);
  final getAuthStateUseCase = GetAuthStateUseCase(authRepository);

  final rideService = RideService();
  final rideRepository = FirebaseRideRepository(rideService);
  final createRideUseCase = CreateRideUseCase(rideRepository);
  final getRidesForUserUseCase = GetRidesForUserUseCase(rideRepository);
  final getActiveRideUseCase = GetActiveRideUseCase(rideRepository);
  final updateRideStatusUseCase = UpdateRideStatusUseCase(rideRepository);

  runApp(
    MyApp(
      authService: finalAuthService,
      signUpUseCase: signUpUseCase,
      signInUseCase: signInUseCase,
      signOutUseCase: signOutUseCase,
      getAuthStateUseCase: getAuthStateUseCase,
      createRideUseCase: createRideUseCase,
      getRidesForUserUseCase: getRidesForUserUseCase,
      getActiveRideUseCase: getActiveRideUseCase,
      updateRideStatusUseCase: updateRideStatusUseCase,
      rideRepository: rideRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetAuthStateUseCase getAuthStateUseCase;
  final CreateRideUseCase createRideUseCase;
  final GetRidesForUserUseCase getRidesForUserUseCase;
  final GetActiveRideUseCase getActiveRideUseCase;
  final UpdateRideStatusUseCase updateRideStatusUseCase;
  final RideRepository rideRepository;

  const MyApp({
    super.key,
    required this.authService,
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.getAuthStateUseCase,
    required this.createRideUseCase,
    required this.getRidesForUserUseCase,
    required this.getActiveRideUseCase,
    required this.updateRideStatusUseCase,
    required this.rideRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ride Tracking Platform',
      theme: AppTheme.lightTheme,
      initialRoute: Routes.travelerHome,
      routes: {
        Routes.login: (context) => LoginPage(),
        Routes.signup: (context) => SignupPage(),
        Routes.roleSelection: (context) => const RoleSelectionPage(),
        Routes.travelerHome: (context) => const TravelerHome(),
        Routes.createRide: (context) => const CreateRidePage(),
        Routes.activeRide: (context) => const ActiveRidePage(),
        Routes.shareAudit: (context) => const ShareAuditPage(),
        Routes.companionHome: (context) => const CompanionHome(),
        Routes.trackRide: (context) => const TrackRidePage(),
        Routes.feedback: (context) => const FeedbackPage(),
        Routes.adminDashboard: (context) => const AdminDashboard(),
        Routes.rideDetail: (context) => const RideDetailPage(),
      },
    );
  }
}
