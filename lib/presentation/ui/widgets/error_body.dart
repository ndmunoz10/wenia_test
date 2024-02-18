import 'package:flutter/material.dart';
import 'package:wenia_test/presentation/ui/styles/text_styles.dart';
import 'package:wenia_test/presentation/ui/widgets/main_button.dart';

class ErrorBody extends StatelessWidget {
  const ErrorBody({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildErrorMessage(),
        const SizedBox(height: 16),
        _buildErrorButton(),
      ],
    );
  }

  Widget _buildErrorMessage() {
    return Text(
      'There was an error fetching the data',
      style: bodyTextStyle.copyWith(
        fontSize: 24,
      ),
    );
  }

  Widget _buildErrorButton() {
    return MainButton(
      onTap: onTap,
      text: 'Try again',
      textStyle: ctaTextStyle.copyWith(color: Colors.black),
    );
  }
}
