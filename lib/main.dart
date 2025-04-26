import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/booking/payment_screen.dart';
import 'screens/home/bookings_screen.dart';
import 'screens/intro_screen/intro_pages.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/home/home_screen.dart';
import 'screens/booking/booking_screen.dart';
import 'screens/booking/booking_confirmation.dart';
import 'screens/booking/lab_selection_screen.dart';
import 'providers/bookings_provider.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // يمكن إضافة المزيد من الـ Providers هنا
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingProvider(), // إضافة Provider هنا
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medscan App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const OnboardingScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => const HomeScreen(),
          '/booking': (context) => BookingScreen(),
          '/booking history': (context) => BookingsHistoryScreen(),
          '/labs': (context) => LabSelectionScreen(),
          '/payment': (context) => PaymentScreen(),
          '/confirmation': (context) {
            final args =
                ModalRoute.of(context)!.settings.arguments as Map<String, String>;
            return BookingConfirmationScreen(
              labName: args['labName']!,
              serviceName: args['serviceName']!,
            );
          },
        },
      ),
    );
  }
}
