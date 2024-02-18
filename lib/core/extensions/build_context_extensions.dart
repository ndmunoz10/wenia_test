import 'package:flutter/material.dart';
import 'package:wenia_test/presentation/ui/widgets/loading_body.dart';

extension BuildContextExtensions on BuildContext {
  Future<void> showLoadingDialog() {
    return showDialog(
      context: this,
      builder: (_) => const LoadingBody(),
    );
  }

  void showSnackBar({required final String text}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(text)));
  }

  void showBottomSheet({required final List<Widget> children}) {
    showModalBottomSheet(
      context: this,
      isDismissible: true,
      builder: (_) => ListView.separated(
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (context, index) => const Divider(indent: 4, endIndent: 4),
      ),
      showDragHandle: true,
      isScrollControlled: true,
    );
  }
}
