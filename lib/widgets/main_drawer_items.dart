import 'package:flutter/material.dart';

class MainDrawerItem extends StatelessWidget {
  const MainDrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onSelectScreen,
  });

  final String title;
  final IconData icon;
  final void Function(String) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 24,
            ),
      ),
      onTap: () {
        onSelectScreen(title.toLowerCase());
      },
    );
  }
}
