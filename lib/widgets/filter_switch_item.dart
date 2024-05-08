import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/providers/filters_provider.dart';

class FilterSwitchItem extends ConsumerWidget {
  const FilterSwitchItem({
    super.key,
    required this.filter,
    required this.title,
  });

  final Filter filter;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      value: ref.watch(filterProvider)[filter]!,
      onChanged: (isChecked) {
        ref.read(filterProvider.notifier).setFilter(filter, isChecked);
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
