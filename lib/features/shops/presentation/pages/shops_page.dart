import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junkpoint/core/common/widgets/loader.dart';
import 'package:junkpoint/core/utils/show_snackbar.dart';
import 'package:junkpoint/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:junkpoint/features/auth/presentation/pages/start_page.dart';
import 'package:junkpoint/features/auth/presentation/widgets/auth_button.dart';

class ShopsPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ShopsPage(),
      );
  const ShopsPage({super.key});

  @override
  State<ShopsPage> createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            } else if (state is AuthInitial) {
              Navigator.push(context, StartPage.route());
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Logged in as Client"),
                AuthButton(
                  buttonText: "Log Out",
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogOut());
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
