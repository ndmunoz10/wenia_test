import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wenia_test/core/di/di.dart';
import 'package:wenia_test/core/router/router.dart';
import 'package:wenia_test/core/router/routes.dart';
import 'package:wenia_test/presentation/features/auth/auth_cubit.dart';

class AuthGuard extends StatelessWidget {
  const AuthGuard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>()..checkAuthChanges(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.when(
            uninitialized: () {},
            authenticated: () => router.go(Routes.allCryptScreen),
            unauthenticated: () => router.go(Routes.loginScreen),
          );
        },
        child: child,
      ),
    );
  }
}
