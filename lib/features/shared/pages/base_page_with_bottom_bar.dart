import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show StatefulNavigationShell;

part '../widgets/custom_bottom_bar.dart';

final class BasePageWithBottomBar extends StatefulWidget {
  const BasePageWithBottomBar({required this.child, super.key});

  final StatefulNavigationShell child;

  @override
  State<BasePageWithBottomBar> createState() => _BasePageWithBottomBarState();
}

final class _BasePageWithBottomBarState extends State<BasePageWithBottomBar> {
  Future<void> goToBranch(int? index) async {
    if (index == null) return;
    final isSameBranch = index == widget.child.currentIndex;
    if (isSameBranch) return;
    widget.child.goBranch(index,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CustomBottomBar(
        onTap: goToBranch,
        currentIndex: widget.child.currentIndex,
      ),
    );
  }
}
