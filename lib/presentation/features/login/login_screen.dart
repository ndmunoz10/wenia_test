import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wenia_test/core/extensions/build_context_extensions.dart';
import 'package:wenia_test/presentation/features/login/login_cubit.dart';
import 'package:wenia_test/presentation/ui/styles/text_styles.dart';
import 'package:wenia_test/presentation/ui/widgets/loading_body.dart';
import 'package:wenia_test/presentation/ui/widgets/main_button.dart';
import 'package:wenia_test/gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _offset = Tween<Offset>(begin: const Offset(0, 1.5), end: const Offset(0, 0.05)).animate(_controller);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: SafeArea(
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              state.maybeWhen(
                error: (final String message) => context.showSnackBar(text: message),
                orElse: () {},
              );
            },
            builder: (context, state) {
              return state.map(
                loading: (_) => _buildLoginBody(isLoading: true),
                idle: (_) => _buildLoginBody(),
                error: (_) => _buildLoginBody(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBody({final bool isLoading = false}) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              _buildSubtitle(),
              const Expanded(child: SizedBox.shrink()),
              _buildCTA(),
            ],
          ),
        ),
        _buildCenterImage(),
        _buildFormContainer(),
        isLoading ? const LoadingBody() : const SizedBox.shrink()
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      'Get started!',
      style: titleTextStyle,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Best way to manage your finances',
      style: bodyTextStyle,
    );
  }

  Widget _buildCTA() {
    return Align(
      alignment: Alignment.center,
      child: MainButton(
        onTap: () => _controller.forward(),
        text: 'Authenticate',
        textStyle: ctaTextStyle.copyWith(color: Colors.black),
      ),
    );
  }

  Widget _buildCenterImage() {
    return Positioned.fill(
      child: Center(
        child: Assets.images.dollarSign.svg(width: 100),
      ),
    );
  }

  Widget _buildFormContainer() {
    final loginCubit = context.read<LoginCubit>();
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: _offset,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          ),
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildEmailTextField(loginCubit),
              const SizedBox(height: 24),
              _buildPasswordTextField(),
              const Expanded(child: SizedBox.shrink()),
              _buildLoginButton(loginCubit)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField(final LoginCubit cubit) {
    return Form(
      key: _emailKey,
      child: TextFormField(
        style: bodyTextStyle.copyWith(color: Colors.black87),
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        controller: _emailController,
        validator: cubit.emailValidator,
        decoration: InputDecoration(
            filled: true,
            hintText: 'Email',
            hintStyle: bodyTextStyle.copyWith(color: Colors.black54),
            fillColor: Colors.black.withAlpha(30),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32), borderSide: BorderSide.none)),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      key: _passwordKey,
      style: bodyTextStyle.copyWith(color: Colors.black87),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      autocorrect: false,
      controller: _passwordController,
      decoration: InputDecoration(
          filled: true,
          hintText: 'Password',
          hintStyle: bodyTextStyle.copyWith(color: Colors.black54),
          fillColor: Colors.black.withAlpha(30),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32), borderSide: BorderSide.none)),
    );
  }

  Widget _buildLoginButton(final LoginCubit cubit) {
    return Align(
      alignment: Alignment.center,
      child: MainButton(
        onTap: () {
          if (_emailKey.currentState!.validate()) {
            cubit.authUser(
              _emailController.text,
              _passwordController.text,
            );
          }
        },
        text: 'Confirm',
        textStyle: ctaTextStyle.copyWith(color: Colors.black),
        backgroundColor: Colors.black,
        borderColor: Colors.black,
      ),
    );
  }
}
