import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/filter_switch_item.dart';
import 'package:meals/widgets/main_drawer.dart';

Map<Filter, bool> _defaultFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _tabIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = _defaultFilters;

  void _setIndex(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _setFavoriteMealStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage('${meal.title} is no longer a favorite.');
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('${meal.title} is a favorite.');
      });
    }
  }

  void _setScreen(String title) async {
    Navigator.of(context).pop();
    if (title == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(selectedFilters: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = result ?? _defaultFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);

    List<Meal> filteredMeals = meals.where(
      (meal) {
        if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
          return false;
        }
        if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        return true;
      },
    ).toList();

    List<Map<String, Object>> availableTabScreens = [
      {
        'title': 'Categories',
        'screen': CategoriesScreen(
          onSelectFavorite: _setFavoriteMealStatus,
          filteredMeals: filteredMeals,
        ),
      },
      {
        'title': 'You Favorites',
        'screen': MealsScreen(
          onSelectFavorite: _setFavoriteMealStatus,
          meals: _favoriteMeals,
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
