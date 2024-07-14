import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junkpoint/core/theme/theme.dart';
import 'package:junkpoint/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:junkpoint/features/auth/presentation/pages/start_page.dart';
import 'package:junkpoint/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightThemeMode,
      home: const StartPage(),
    );
  }
}
