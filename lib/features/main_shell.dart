import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:vsi_assessment/core/constants/shell_constants.dart';
import 'package:vsi_assessment/core/layout/app_page_frame.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const List<IconData> _tabIcons = [
    Iconsax.document_text,
    Iconsax.book_1,
    Iconsax.people,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ShellConstants.appBarTitles[navigationShell.currentIndex],
        ),
      ),
      body: AppPageFrame(
        child: navigationShell,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
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
