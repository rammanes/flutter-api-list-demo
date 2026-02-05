import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:vsi_assessment/core/constants/shell_constants.dart';
import 'package:vsi_assessment/core/network/network_error_notifier.dart';
import 'package:vsi_assessment/core/widgets/custom_snackbar.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const List<IconData> _tabIcons = [
    Iconsax.document_text,
    Iconsax.book_1,
    Iconsax.people,
  ];

  bool _lastNetworkError = false;

  @override
  void initState() {
    super.initState();
    networkErrorNotifier.addListener(_onNetworkErrorChanged);
  }

  @override
  void dispose() {
    networkErrorNotifier.removeListener(_onNetworkErrorChanged);
    super.dispose();
  }

  void _onNetworkErrorChanged() {
    final isError = networkErrorNotifier.value;
    if (isError && !_lastNetworkError && mounted) {
      CustomSnackbar.show(context, 'Network not available', isError: true);
    }
    _lastNetworkError = isError;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (index) => widget.navigationShell.goBranch(index),
        type: BottomNavigationBarType.fixed,
        items: List.generate(
          ShellConstants.tabLabels.length,
          (i) => BottomNavigationBarItem(
            icon: Icon(_tabIcons[i]),
            label: ShellConstants.tabLabels[i],
          ),
        ),
      ),
    );
  }
}
