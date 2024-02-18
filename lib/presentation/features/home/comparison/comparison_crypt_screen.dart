import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wenia_test/core/extensions/build_context_extensions.dart';
import 'package:wenia_test/core/utils/number_format_utils.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/presentation/features/home/comparison/comparison_crypt_cubit.dart';
import 'package:wenia_test/presentation/ui/styles/text_styles.dart';
import 'package:wenia_test/presentation/ui/widgets/crypt/comparison_crypt_item.dart';
import 'package:wenia_test/presentation/ui/widgets/error_body.dart';
import 'package:wenia_test/presentation/ui/widgets/loading_body.dart';

class ComparisonCryptScreen extends StatefulWidget {
  const ComparisonCryptScreen({super.key});

  @override
  State<ComparisonCryptScreen> createState() => _ComparisonCryptScreenState();
}

class _ComparisonCryptScreenState extends State<ComparisonCryptScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ComparisonCryptCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ComparisonCryptCubit, ComparisonCryptState>(
        builder: (context, state) {
          if (state.errorMessage != null) {
            return Center(
              child: ErrorBody(
                onTap: () => context.read<ComparisonCryptCubit>().init(),
              ),
            );
          }
          return _buildComparisonBody(
            isLoading: state.isLoading,
            leftCrypt: state.leftCrypt,
            rightCrypt: state.rightCrypt,
          );
        },
      ),
    );
  }

  Widget _buildComparisonBody({
    required final bool isLoading,
    required final CryptModel? rightCrypt,
    required final CryptModel? leftCrypt,
  }) {
    if (isLoading) {
      return const LoadingBody();
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            _buildSubtitle(),
            const SizedBox(height: 16),
            Expanded(
              child: Row(
                children: [
                  _buildLeftContainer(leftCrypt),
                  const Icon(Icons.compare_arrows, size: 50, color: Colors.white),
                  _buildRightContainer(rightCrypt),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Versus',
      style: titleTextStyle,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Tap a side to select a coin and compare',
      style: bodyTextStyle.copyWith(
        fontSize: 24,
        color: Colors.white70,
      ),
    );
  }

  Widget _buildLeftContainer(final CryptModel? crypt) {
    final cubit = context.read<ComparisonCryptCubit>();
    final crypts = cubit.state.crypts
        .map((crypt) => ComparisonCryptItem(
              crypt: crypt,
              onTap: () {
                cubit.onLeftSelected(crypt);
                context.pop();
              },
            ))
        .toList();
    final Widget child;
    if (crypt == null) {
      child = Text(
        'Tap to select a coin',
        style: bodyTextStyle.copyWith(fontSize: 32),
      );
    } else {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            crypt.name,
            style: bodyTextStyle.copyWith(fontSize: 24),
            textAlign: TextAlign.start,
          ),
          Text(
            crypt.symbol.toUpperCase(),
            style: bodyTextStyle.copyWith(fontSize: 24),
            textAlign: TextAlign.start,
          ),
          Text(
            NumberFormatUtils.formatPrice(crypt.price),
            style: bodyTextStyle.copyWith(fontSize: 24),
            textAlign: TextAlign.start,
          ),
        ],
      );
    }
    return Expanded(
      child: GestureDetector(
        onTap: () => context.showBottomSheet(
          children: crypts,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }

  Widget _buildRightContainer(final CryptModel? crypt) {
    final cubit = context.read<ComparisonCryptCubit>();
    final crypts = cubit.state.crypts
        .map((crypt) => ComparisonCryptItem(
              crypt: crypt,
              onTap: () {
                cubit.onRightSelected(crypt);
                context.pop();
              },
            ))
        .toList();
    final Widget child;
    if (crypt == null) {
      child = Text(
        'Tap to select a coin',
        style: bodyTextStyle.copyWith(fontSize: 32),
        textAlign: TextAlign.end,
      );
    } else {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            crypt.name,
            style: bodyTextStyle.copyWith(fontSize: 24),
            textAlign: TextAlign.end,
          ),
          Text(
            crypt.symbol.toUpperCase(),
            style: bodyTextStyle.copyWith(fontSize: 24),
            textAlign: TextAlign.end,
          ),
          Text(
            NumberFormatUtils.formatPrice(crypt.price),
            style: bodyTextStyle.copyWith(fontSize: 24),
            textAlign: TextAlign.end,
          ),
        ],
      );
    }
    return Expanded(
      child: GestureDetector(
        onTap: () => context.showBottomSheet(
          children: crypts,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
