import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet4u/features/home/bloc/home_bloc.dart';
import 'package:pet4u/features/home/screens/home_screen.dart';
import 'package:pet4u/features/theme/bloc/theme_bloc.dart';
import 'package:pet4u/features/theme/bloc/theme_event.dart';
import 'package:pet4u/features/theme/bloc/theme_state.dart';
import 'package:pet4u/features/theme/custom_theme.dart';
import 'package:pet4u/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()..add(ThemeInitEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeLoadingState) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: customLightTheme,
            home: const CircularProgressIndicator(),
          );
        }
        if (state is ThemeChangedState) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.themeData,
            home: const HomeScreen(),
          );
        }
        return MaterialApp(
          title: 'Flutter Demo',
          theme: customLightTheme,
          home: const HomeScreen(),
        );
      },
    );
  }
}
