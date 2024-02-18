import 'package:flutter/material.dart';
import 'package:wenia_test/core/utils/number_format_utils.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/presentation/ui/styles/text_styles.dart';

class ComparisonCryptItem extends StatelessWidget {
  const ComparisonCryptItem({
    required this.crypt,
    required this.onTap,
    super.key,
  });

  final CryptModel crypt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 20,
              child: Image.network(
                crypt.image,
                width: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    crypt.name,
                    style: bodyTextStyle.copyWith(fontSize: 20, color: Colors.black),
                  ),
                  Text(
                    crypt.symbol.toUpperCase(),
                    style: bodyTextStyle.copyWith(fontSize: 20, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 40,
              child: Text(
                NumberFormatUtils.formatPrice(crypt.price),
                style: bodyTextStyle.copyWith(color: Colors.black),
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
