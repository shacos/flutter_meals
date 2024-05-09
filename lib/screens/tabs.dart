import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _tabIndex = 0;

  void _setIndex(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  void _setScreen(String title) {
    Navigator.of(context).pop();
    if (title == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoriteMealProvider);

    List<Meal> filteredMeals = ref.watch(filteredMealsProvider);

    List<Map<String, Object>> availableTabScreens = [
      {
        'title': 'Categories',
        'screen': CategoriesScreen(
          filteredMeals: filteredMeals,
        ),
      },
      {
        'title': 'You Favorites',
        'screen': MealsScreen(
          meals: favoriteMeals,
        )
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(availableTabScreens[_tabIndex]['title'] as String),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: availableTabScreens[_tabIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _setIndex,
        currentIndex: _tabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
