import 'package:flutter/material.dart';
import 'package:hirent2/screens/otp_screen.dart';
import 'package:hirent2/screens/sharedpref.dart';
import 'package:hirent2/screens/sign_in_screen.dart';
import 'package:hirent2/screens/signup_screen.dart';
import 'package:hirent2/screens/tp_profile_screen.dart';
import 'package:hirent2/screens/tp_chatting.dart';
import 'package:hirent2/screens/tp_mytask.dart';
import 'package:hirent2/screens/ts_chatting_screen.dart';
import 'package:hirent2/screens/ts_homescreen.dart';
import 'package:hirent2/screens/your_tasks.dart' as tasks;
import 'package:hirent2/screens/splash_screen.dart';
import 'package:hirent2/screens/role_selection.dart';
import 'package:hirent2/screens/tp_homepage.dart';
import 'package:hirent2/screens/ts_profile_screen.dart';
import 'package:hirent2/screens/create_task.dart';
import 'package:hirent2/screens/settings.dart';
import 'package:hirent2/screens/wallet.dart';
import 'package:hirent2/screens/security.dart';
import 'package:hirent2/screens/payment_history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefService.init();
  runApp(const HirentApp());
}

class HirentApp extends StatelessWidget {
  const HirentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        primaryColor: const Color(0xFFD8B4F8),
      ),
      home: const SplashScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/otp') {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (context) => OTPVerificationPage(signUpData: args ?? {}),
            settings: RouteSettings(arguments: args),
          );
        }

        switch (settings.name) {
          case '/signin':
            return MaterialPageRoute(builder: (_) => const SignInPage());
          case '/signup':
            return MaterialPageRoute(
                builder: (_) => const SignUpScreen(selectedRole: ''));
          case '/seekerMain':
            return MaterialPageRoute(
                builder: (_) => TsHomePage(
                      seekerId: '68225f34d92bb78dd1e27274',
                    ));
          case '/providerMain':
            return MaterialPageRoute(builder: (_) => TpHomeScreen());
          case '/ts_profile':
            return MaterialPageRoute(builder: (_) => TSProfileSettingsPage());
          case '/tp_profile':
            return MaterialPageRoute(builder: (_) => TPProfileSettingsPage());
          case '/ts_yourtasks':
            return MaterialPageRoute(builder: (_) => tasks.YourTasksPage());
          case '/tp_yourtasks':
            return MaterialPageRoute(builder: (_) => MyTasksScreen());
          case '/role':
            return MaterialPageRoute(builder: (_) => RoleSelectionPage());
          case '/seekerLogin':
            return MaterialPageRoute(
                builder: (_) => const SignUpScreen(selectedRole: ''));
          case '/providerLogin':
            return MaterialPageRoute(
                builder: (_) => const SignUpScreen(selectedRole: ''));
          case '/settings':
            return MaterialPageRoute(builder: (_) => SettingsPage());
          case '/wallet':
            return MaterialPageRoute(
                builder: (_) => WalletPage(
                      userId: '',
                    ));
          case '/security':
            return MaterialPageRoute(builder: (_) => SecurityPage());
          case '/paymentHistory':
            return MaterialPageRoute(builder: (_) => PaymentHistoryPage());
          case '/ts_messages':
            final args = settings.arguments as Map<String, dynamic>?;

            final currentUser =
                args != null ? args['currentUser'] as String : '';

            return MaterialPageRoute(
              builder: (_) => TsChatScreen(currentUser: currentUser),
            );

          case '/tp_messages':
            final args = settings.arguments as Map<String, dynamic>?;

            final currentUser =
                args != null ? args['currentUser'] as String : '';

            return MaterialPageRoute(
              builder: (_) => TsChatScreen(currentUser: currentUser),
            );
          case '/createTask':
            return MaterialPageRoute(
                builder: (_) => CreateTaskScreen(
                      currentUserId: '',
                    ));
          default:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
        }
      },
    );
  }
}
