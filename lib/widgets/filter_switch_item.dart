import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterSwitchItem extends StatelessWidget {
  const FilterSwitchItem({
    super.key,
    required this.switchValue,
    required this.filter,
    required this.onToggelSwitch,
    required this.title,
  });

  final bool switchValue;
  final Filter filter;
  final void Function(bool, Filter) onToggelSwitch;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: switchValue,
      onChanged: (isChecked) {
        onToggelSwitch(isChecked, filter);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        'Only include ${title.toLowerCase()} meals.',
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(right: 34, left: 22),
    );
  }
}
