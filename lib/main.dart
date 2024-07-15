import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junkpoint/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:junkpoint/core/theme/theme.dart';
import 'package:junkpoint/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:junkpoint/features/auth/presentation/pages/start_page.dart';
import 'package:junkpoint/features/orders/presentation/pages/orders_page.dart';
import 'package:junkpoint/features/shops/presentation/pages/shops_page.dart';
import 'package:junkpoint/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, int>(
        selector: (state) {
          if (state is AppUserLoggedIn) {
            if (state.user.isLeft()) return 1;
            return 2;
          }
          return 0;
        },
        builder: (context, state) {
          if (state > 0) {
            // print(state == 2);
            if (state == 1) return const ShopsPage();
            if (state == 2) return const OrdersPage();
          }
          return const StartPage();
        },
      ),
    );
  }
}
