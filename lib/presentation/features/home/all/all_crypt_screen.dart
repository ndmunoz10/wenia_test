import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wenia_test/presentation/features/home/all/all_crypt_cubit.dart';
import 'package:wenia_test/presentation/ui/styles/text_styles.dart';
import 'package:wenia_test/presentation/ui/widgets/crypt/crypt_item.dart';
import 'package:wenia_test/presentation/ui/widgets/error_body.dart';

class AllCryptScreen extends StatefulWidget {
  const AllCryptScreen({super.key});

  @override
  State<AllCryptScreen> createState() => _AllCryptScreenState();
}

class _AllCryptScreenState extends State<AllCryptScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AllCryptCubit>()..init();
    _searchController.addListener(() {
      cubit.filterByText(_searchController.text);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        cubit.fetchCryptData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllCryptCubit, AllCryptState>(
        builder: (context, state) {
          if (state.errorMessage != null) {
            return Center(
              child: ErrorBody(
                onTap: () => context.read<AllCryptCubit>().fetchCryptData(),
              ),
            );
          }
          return SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTitle(),
                        IconButton(
                          onPressed: context.read<AllCryptCubit>().logout,
                          icon: const Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSearchBar(),
                    const SizedBox(height: 16),
                    _buildCryptList(state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      style: bodyTextStyle.copyWith(color: Colors.black87),
      autocorrect: false,
      controller: _searchController,
      decoration: InputDecoration(
          filled: true,
          hintText: 'Type something',
          hintStyle: bodyTextStyle.copyWith(color: Colors.black),
          fillColor: Colors.white70,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32), borderSide: BorderSide.none)),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Crypto Info',
      style: titleTextStyle,
    );
  }

  Widget _buildCryptList(final AllCryptState state) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        controller: _scrollController,
        itemCount: state.filteredCrypts.length + 1,
        itemBuilder: (context, index) {
          final crypt = state.filteredCrypts.elementAtOrNull(index);
          if (crypt != null) {
            return CryptItem(
              crypt: state.filteredCrypts[index],
              onTap: () => context.read<AllCryptCubit>().handleAsFavorite(crypt: state.filteredCrypts[index]),
            );
          } else if (index == state.filteredCrypts.length && state.isLoading) {
            return const IntrinsicWidth(
              child: SizedBox(
                width: 50,
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
