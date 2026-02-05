import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.titleColor,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.backgroundColor,
    this.elevation = 0,
    this.centerTitle = true,
    this.bottom,
    this.toolbarHeight,
  });

  final String? title;
  final Widget? titleWidget;
  final Color? titleColor;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final Widget? leading;
  final Color? backgroundColor;
  final double elevation;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final double? toolbarHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      centerTitle: centerTitle,
      toolbarHeight: toolbarHeight,
      title: titleWidget ??
          Text(
            title ?? '',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: titleColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    final base = toolbarHeight ?? kToolbarHeight;
    final bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(base + bottomHeight);
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        if (subtitle != null && subtitle!.trim().isNotEmpty)
          Text(
            subtitle!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
      ],
    );
  }
}
