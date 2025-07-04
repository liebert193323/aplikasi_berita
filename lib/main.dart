import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'providers/theme_provider.dart';
import 'services/bookmark_service.dart';
import 'screens/register_screen.dart';
import 'screens/isi_profil_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';

enum NewsSource { indo, luar }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  // Initialize AuthService
  await AuthService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkService()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Aplikasi Berita',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,

            // ─── Tema terang ───
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              primarySwatch: Colors.deepPurple,
              scaffoldBackgroundColor: const Color(0xFFF3F4F6),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFFF3F4F6),
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.deepPurple,
                unselectedItemColor: Colors.grey,
              ),
            ),

            // ─── Tema gelap ───
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              primarySwatch: Colors.deepPurple,
              scaffoldBackgroundColor: const Color(0xFF121212),
              cardColor: const Color(0xFF1E1E1E),
              dividerColor: Colors.white24,
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF121212),
                elevation: 0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Color(0xFF1E1E1E),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
              ),
            ),

            // ─── Halaman awal ───
            home: const LoginScreen(),

            // ─── Daftar route ───
            routes: {
              '/register':        (context) => const RegisterScreen(),
              '/isi-profil':      (context) => const IsiProfilScreen(),
              '/home':            (context) => const HomeScreen(),
              '/login':           (context) => const LoginScreen(),
            },
          );
        },
      ),
    );
  }
}