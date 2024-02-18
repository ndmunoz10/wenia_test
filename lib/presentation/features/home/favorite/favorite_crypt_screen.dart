import 'package:flutter/material.dart';
import 'package:wenia_test/core/di/di.dart';
import 'package:wenia_test/domain/models/crypt_model.dart';
import 'package:wenia_test/presentation/features/home/favorite/favorite_crypt_cubit.dart';
import 'package:wenia_test/presentation/ui/styles/text_styles.dart';
import 'package:wenia_test/presentation/ui/widgets/crypt/crypt_item.dart';

class FavoriteCryptScreen extends StatelessWidget {
  FavoriteCryptScreen({super.key});

  final FavoriteCryptCubit _cubit = FavoriteCryptCubit(sl(), sl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              const SizedBox(height: 16),
              _buildCryptList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Your Favs',
      style: titleTextStyle,
    );
  }

  Widget _buildCryptList() {
    return Expanded(
      child: StreamBuilder<List<CryptModel>>(
        stream: _cubit.getFavoriteCrypts(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.separated(
              itemBuilder: (context, index) => CryptItem(
                crypt: snapshot.data![index],
                onTap: () => _cubit.handleAsFavorite(crypt: snapshot.data![index]),
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data!.length,
            );
          } else {
            return Center(
              child: Text(
                'Your 🤍 cryptos will appear here!',
                style: bodyTextStyle.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
